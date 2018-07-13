/* Copyright (C) 2002 Albert Tumanov

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

*/

package net.sourceforge.pldoc;

import java.io.*;
import java.util.*;
import java.text.DateFormat;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMResult;
import net.sourceforge.pldoc.parser.PLSQLParser;
import net.sourceforge.pldoc.parser.ParseException;
import net.sourceforge.pldoc.DbmsMetadata;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.NamedNodeMap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;


/**
 * PL/SQL documentation generator.
 * <p>
 *
 * 2006-05-16 - Matthias Hendler - Rewritten execption handling in Methode run and processPackage.
 *                                 Now the program ignores not only exceptions thrown by the parser
 *                                 but also thrown errors.
 *                                 Also a summary of skipped packages will be written to stderr at the program end.
 *                                 User can specify if he wants to get a generator summary in which he can see errors
 *                                 encountered during processing packages.
 *                                 Creation date is also added to the XML document (application.xml) for further XSLT processing.
 *
 * @author Albert Tumanov
 * @version $Header: /cvsroot/pldoc/sources/src/java/net/sourceforge/pldoc/PLDoc.java,v 1.13 2005/11/29 08:25:00 gpaulissen Exp $
 * </p>
 */
public class PLDoc
{
  // The exception is used when system exit is desired but "finally" clause need also to be run.
  private static class SystemExitException extends RuntimeException {
    /** Serial UID */
    static final long serialVersionUID = 1L;


    /** Default-Konstruktor */
    SystemExitException() {
      super();
    }

    /** Konstruktor with cause */
    SystemExitException(Throwable t) {
      super(t);
    }
  }

  private static final String lineSeparator = System.getProperty("line.separator");
  private static String programName = "PLDoc version: " + Version.id();
  private static HashMap hashMap = new HashMap();
  static {
    /*
    Put mappings for object types where the DBMS_METADATA.GET_DDL(OBJECT_TYPE) parameter
    differs from the contents of the dba_objects.object_type column,
    either because the  because we just want the spcification
    */
    hashMap.put( "PACKAGE", "PACKAGE_SPEC" );
    hashMap.put( "TYPE", "TYPE_SPEC" );
    hashMap.put( "PACKAGE BODY", "PACKAGE_BODY" );
    hashMap.put( "TYPE BODY", "TYPE_BODY" );
    hashMap.put( "JAVA SOURCE", "JAVA_SOURCE" ); // Attempt to document Java

  }

    /** Map OBJECT TYPES to source file suffixes
    */
  private static HashMap fileSuffixMap = new HashMap();
  static {
    fileSuffixMap.put( "PROCEDURE", "prc" );
    fileSuffixMap.put( "FUNCTION", "fnc" );
    fileSuffixMap.put( "TRIGGER", "trg" );
    fileSuffixMap.put( "PACKAGE", "pks" );
    fileSuffixMap.put( "TYPE", "tps" );
    fileSuffixMap.put( "PACKAGE BODY", "pkb" );
    fileSuffixMap.put( "TYPE BODY", "tpb" );
    fileSuffixMap.put( "JAVA SOURCE", "java" ); 

  }

  private boolean dictionaryViewsHaveReverted = false ; // 

  private static HashMap<String,HashMap<String,String>> plscopeQueriesMap = new HashMap<String,HashMap<String,String>>();
  static {
   //DEFAULT to using the DBA_* dictionary views, available if the connected user has been granted SELECT_CATALOG_ROLE  
   plscopeQueriesMap.put("DEFAULT", new HashMap()  );
   plscopeQueriesMap.get("DEFAULT").put("SIGNATURES", "plscope/plscope_signatures.sql" );
   plscopeQueriesMap.get("DEFAULT").put("CALLS", "plscope/plscope_call.sql")  ;

   //Revert to using the ALL_* dictionary views 
   plscopeQueriesMap.put("ALL_", new HashMap()  );
   plscopeQueriesMap.get("ALL_").put("SIGNATURES", "plscope/plscope_signatures_all.sql" );
   plscopeQueriesMap.get("ALL_").put("CALLS", "plscope/plscope_call_all.sql")  ;

  }

  // Helper objects for retrieving resources relative to the installation.
  public static final ResourceResolver resResolver = new ResourceResolver();
  public static final ResourceLoader resLoader = new ResourceLoader();

  //Initially use default queries for retrieving PLScope information 
  private HashMap plscopeQueries = plscopeQueriesMap.get("DEFAULT");  

  // Runtime settings
  public Settings settings;

  /**
  * Create using collected or defaulted settings.
  *
  * @param settings the collected settings from command-line, ANt task or Maven mojo. 
  */
  public PLDoc(Settings settings)
  {
    this.settings = settings;
  }

  /** 
   * Generate PLDoc from the command-line - all settings are passed as command-line parameters
   *
   * @param args all command-line settings 
   * @throws Exception on error 
   */
  public static void main(String[] args) throws Exception
  {
    long startTime = System.currentTimeMillis();
    System.out.println("");
    System.out.println(programName);

    // process arguments
    Settings settings = new Settings();
    settings.processCommandString(args);
    PLDoc pldoc = new PLDoc(settings);

    // start running
    try {
      pldoc.run();
    } catch (SystemExitException e) {
      System.exit(-1);
    }

    long finishTime = System.currentTimeMillis();
    System.out.println("Done (" + (finishTime-startTime)/1000.00 + " seconds).");
  }

  /**
   * Derive PLDoc file name from the object type 
   * 
   * @param schemaName Schema Name DBA_OBJECTS.OWNER 
   * @param objectType Oracle Object Type DBA_OBJECTS.OBJECT_TYPE
   * @param objectName Object Name DBA_OBJECTS.OBJECT_NAME 
   * @return PLDoc file name 
   */
  private String getPLDocFileName 
  (String schemaName
   ,String objectType 
   ,String objectName
  )
  {
    //@TODO hack for object to PLDoc path mapping 
    final String fileSuffix = ".html" ;
    StringBuilder pldocFileName = new StringBuilder();
    if(objectType.equals("PROCEDURE")
       ||
       objectType.equals("FUNCTION")
       ||
       objectType.equals("TRIGGER")
      )
    {
      //@TODO Incorrect for Database Triggers 
      pldocFileName.append("_").append(schemaName).append(fileSuffix).append("#").append(objectName);
    }
    else if(objectType.endsWith(" BODY"))
    {
      pldocFileName.append("_").append(objectName).append(fileSuffix) ;
    }
    else 
    {
      pldocFileName.append(objectName).append(fileSuffix) ;
    }
    
    return pldocFileName.toString() ;

  }

  /**
  * Run PLDoc using the specified settings.
  *
  * @throws Exception on error 
  *
  * 2006-05-16 - Matthias Hendler - Collect some status information during the processing
  *                                 and add them to the application.xml.
  *                                 More verbose output to console added.
  */
  public void run() throws Exception
  {
    long startTime = System.currentTimeMillis();
    //Set of Schemas with Objects
    final HashMap<String,Integer> objectSchemas = new HashMap<String,Integer>();
    // Map with all the packages (like files or database objects) which were skipped
    final SortedMap skippedPackages = new TreeMap();
    // Counts all the packages (like files or database objects) which were processed successfully

    File synonymsFile = new File (settings.getOutputDirectory(), "synonyms.xml" ) ;

    String synonymStatement = "SELECT "+
                          "owner"+
                          ", synonym_name"+
                          ", table_owner"+
                          ", table_name"+
                          " FROM dba_synonyms"+
                          " WHERE owner IN (?)"+
                          " AND   table_owner NOT in ('SYS','SYSTEM')"+
                          " AND   table_name NOT LIKE 'BIN$%'"+ //Exclude tables in the Recycle Bin 
                          " ORDER BY "+
                          " table_owner, table_name"
                          ;
    
    long processedPackages = 0;
    Connection conn = null;
    PreparedStatement pstmt = null;

    File outputDirectory = settings.getOutputDirectory();
    // if the output directory do not exist, create it
    if (!settings.getOutputDirectory().exists()) {
      System.out.println("Directory \"" + settings.getOutputDirectory() + "\" does not exist, creating ...");
      settings.getOutputDirectory().mkdir();
    }

    // open the output file (named application.xml)
    File applicationFile = new File(
      settings.getOutputDirectory().getPath() + File.separator + "application.xml");
    OutputStream output = null;
    try {
      output = new FileOutputStream(applicationFile);
      XMLWriter xmlOut = new XMLWriter(output);
      xmlOut.setMethod("xml");
      if (settings.getOutputEncoding() != null)
        xmlOut.setEncoding(settings.getOutputEncoding());
      xmlOut.setIndent(true);
      xmlOut.setDocType(null, "application.dtd");
      xmlOut.startDocument();
      xmlOut.pushAttribute("NAME", settings.getApplicationName());
      xmlOut.startElement("APPLICATION");

      // read overview file content
      if (settings.getOverviewFile() != null) {
        // overview of the application
        xmlOut.startElement("OVERVIEW");
        xmlOut.cdata(getOverviewFileContent(settings.getOverviewFile()));
        xmlOut.endElement("OVERVIEW");
      }

      //Frig to allow compilation with JAVA_UNICODE_ESCAPE without allowing Unicode Escape characters  
      //String oldpropertyValue = settings.getDefines().setProperty("\\u","\\\\");
      // for all the input files
      Iterator it = settings.getInputFiles().iterator();
      while (it.hasNext()) {
        String inputFileName = (String) it.next();
        final String packagename = inputFileName;

        // open the input file
        if (settings.isVerbose() ) System.out.println("Parsing file " + inputFileName + " ...");

        try {
	  /* Allow the schema to be defaulted even when parsing files */
	  String schemaName = settings.getDbUser() ;
          InputStreamReader inputStreamReader;
	  BufferedReader bufferedReader = 
            new BufferedReader(
              inputStreamReader = new InputStreamReader(
				                         Utils.getBOMInputStream(new FileInputStream(inputFileName)
								                , settings.getInputEncoding()
								 		)
		                                         ,settings.getInputEncoding()
				                         )
	      )
            ;

          if (settings.isVerbose() ) 
	  {
	  	System.out.println("Processing : " + inputFileName + " as inputEncoding=\"" + settings.getInputEncoding() 
	                     + "\" via inputStreamReader encoding=\""+inputStreamReader.getEncoding() +"\""
	                    );
	  }

          final Throwable throwable = processPackage(
	      bufferedReader
	      ,
              xmlOut, packagename
	      , (null == schemaName || schemaName.equals("") ) ? "" :  schemaName//SRT 20110418"" 
	      , (null == schemaName || schemaName.equals("") ) ? "_GLOBAL" : ("_" + schemaName) //SRT 20110418
          );

          // Test the processing result
          if (throwable == null) {
            processedPackages++;
          } else {
            skippedPackages.put(packagename, throwable);
          }
        } catch(FileNotFoundException e) {
          System.err.println("File not found: " + inputFileName);
          throw new SystemExitException(e);
        }
      } // for all the input files.



      // for all the specified packages from the dictionary
      if ( settings.getDbUrl() != null && settings.getDbUser() != null && settings.getDbPassword() != null ) {
        // Load the Required JDBC driver class.
        // DriverManager.registerDriver(new OracleDriver());
	Class.forName(settings.getDriverName());

        // Connection conn = null;
        // PreparedStatement pstmt = null;

        try {
		  /* Move query generation before connecting in order to allow validation of the query with needing a valid datbae to connect to */
		  Collection inputTypes ;
		  String typeList = "" ;
		 /*
		 */
		  if ( null != ( inputTypes = settings.getInputTypes() ) && ! inputTypes.isEmpty() )  
          {
			for (Iterator tt = inputTypes.iterator(); tt.hasNext() ; )
			{
		     String inputType = ((String) tt.next());
			  //Convert the list into quoted, UPPER-cased comma-separated list string
			  typeList += ((0 == typeList.length()) ? "" : ",") // prefix type name with comma for all except first type name
							   + "'"  + inputType.toUpperCase() + "'" ;
			}
	      }


	      //Default List to procedural code only
	      if (typeList.equals(""))
	      {
			// typeList =  'PACKAGE', 'TABLE', 'VIEW','TYPE','PROCEDURE','FUNCTION','MATERIALIZED VIEW'  ;
			 typeList =  "'PACKAGE','TYPE','PROCEDURE','FUNCTION','TRIGGER','TABLE','VIEW'"  ;
		  }


		  String sqlStatement = "SELECT  object_name"+
                                        ", object_type"+
                                        " FROM dba_objects"+
                                        " WHERE owner = ?"+
                                        " AND   object_name LIKE ?"+
                                        " AND  object_type in (" + typeList + ")"+
                                        " AND  object_name NOT LIKE 'BIN$%'"+ //Exclude objects in the Recycle Bin 
                                        " ORDER BY "+
                                        " object_name"
                                        ;


		   if (settings.isVerbose() ) System.out.println("Using \"" + sqlStatement + "\"" );

		   if (settings.isVerbose() ) System.out.println("Connecting ..");
           conn = DriverManager.getConnection( settings.getDbUrl(), settings.getDbUser(), settings.getDbPassword() );
		   if (settings.isVerbose() ) System.out.println("Connected");


    System.out.println("Using \"" + sqlStatement + "\"" );
    //Initially attempt to use DBA_OBJECTS, reverting to ALL_OBJECTS on any error
    pstmt = conn.prepareStatement(sqlStatement);


          DbmsMetadata dbmsMetadata = new DbmsMetadata(conn,settings.getGetMetadataStatement(), settings.getReturnType());

          it = settings.getInputObjects().iterator();
          while (it.hasNext()) {
            String input[] = ((String) it.next()).split("\\."); /* [ SCHEMA . ] PACKAGE */

			if ( input.length == 0 || input.length > 2 )
			{
			continue;
			}

            String inputSchemaName = ( input.length == 2 ? input[0] : settings.getDbUser() );
            String inputObjectName = ( input.length == 2 ? input[1] : input[0] );

            // get the package name(s)
	    ResultSet rset = null;

	    try {
		pstmt.setString(1, inputSchemaName);
		pstmt.setString(2, inputObjectName);

     //Attempt to use DBA_OBJECTS, reverting to ALL_OBJECTS on any error
    try
    {
      rset = pstmt.executeQuery();
    }
    catch (Exception e)
    { 
      if (dictionaryViewsHaveReverted )
      {
        throw new Exception ("Failed to retrieve database objects using  \"" + sqlStatement + "\""  
                             ,e ); //Pass problem up 
      }
      else//Revert to ALL_OBJECTS  
      {
        dictionaryViewsHaveReverted = true ; 
        sqlStatement = sqlStatement.replaceFirst(" dba_", " all_");
	
        //Adjust the SYNONYMS query also
	      synonymStatement = synonymStatement.replaceFirst(" dba_", " all_");
        //Adjust plscope settings to use ALL_* dictionary views 
        plscopeQueries = plscopeQueriesMap.get("ALL_");  
        if (settings.isVerbose() ) System.out.println("Reverting to \"" + sqlStatement + "\"" );
        pstmt = conn.prepareStatement(sqlStatement);
        pstmt.setString(1, inputSchemaName);
        pstmt.setString(2, inputObjectName);
        rset = pstmt.executeQuery();
      }
    }

		// If the object is not present return false
		if (!rset.next()) {
		    // package does not exist

		    System.err.println("Object(s) like " + inputSchemaName + "." + inputObjectName + " do not exist or " + settings.getDbUser() + " does not have enough permissions (SELECT_CATALOG_ROLE role).");
		} else {
		    if (!objectSchemas.containsKey(inputSchemaName))
		    {
		      objectSchemas.put(inputSchemaName,0);
		    }
		    else
		    {
          int schemaReferences = objectSchemas.get(inputSchemaName)  ;
		      objectSchemas.put(inputSchemaName,schemaReferences++)  ;
		    }
		    do {
			  final String packagename = inputSchemaName + "." + rset.getString(1);
			  final String objectType = rset.getString(2) ;
                          //Remap DBA_OBJECTS.OBJECT_TYPE column contents to DBMS_METADATA.GET_DDL(OBJECT_TYPE) parameter if necessary
			  final String dbmsMetadataObjectType = hashMap.containsKey(rset.getString(2)) ? (String) hashMap.get(objectType) : objectType;
			  if (settings.isVerbose() ) System.out.println("Parsing " + objectType + " name " + packagename + " ...");

			if (settings.isVerbose() ) System.err.println("Extracting DBMS_METADATA DDL for (object_type,object_name,schema)=(" + dbmsMetadataObjectType + "," +rset.getString(1) + "," +inputSchemaName  + ") ...");

			final File savedSchemaDirectory = new File (settings.getOutputDirectory(),  inputSchemaName);
			if ( settings.isSaveSourceCode() &&  !savedSchemaDirectory.exists())
			{
			   savedSchemaDirectory.mkdir();
			}
			final File savedObjectTypeDirectory = new File (savedSchemaDirectory,  objectType.replace(' ','_') );  
			if (settings.isSaveSourceCode() )
			{
			  //Create the directory if it does not already exist 
			  if (!savedObjectTypeDirectory.exists())
			  {
			     savedObjectTypeDirectory.mkdir();
			     // copy required static files into the source code directory
			     Utils.copyStaticSourceDirectoryFiles(savedObjectTypeDirectory, "../../" );
			  }
			  //Refresh static files if ther directory existed previously but has not yet been modified in this run 
			  else if (startTime > savedObjectTypeDirectory.lastModified())
			  {
			     // copy required static files into the source code directory
			     Utils.copyStaticSourceDirectoryFiles(savedObjectTypeDirectory, "../../" );
			     if (settings.isVerbose() ) System.err.println("Refreshed static files in " + savedObjectTypeDirectory.getCanonicalPath() );
			  }
			}

			final File savedSourceFile = new File (savedObjectTypeDirectory,  rset.getString(1).replace(' ','_') + "." + fileSuffixMap.get(rset.getString(2)) + ".xml" );  

			FileWriter  savedSourceFileWriter = null; //Set only if needed 
			// crashing the application
			BufferedReader bufferedReader = null;  
			try {
			     if (settings.isSaveSourceCode() )
			     {

				if (settings.isVerbose() ) 
				  System.err.println("Saving DDL for (object_type,object_name,schema)=(" + dbmsMetadataObjectType + "," +rset.getString(1) + "," +inputSchemaName  + ") to "
						      + savedSourceFile.getCanonicalPath()
						      );
				savedSourceFileWriter = new FileWriter(savedSourceFile);
                                //
                                Properties context = new Properties();
                                
                                context.put("schemaName", inputSchemaName);
                                context.put("objectType", dbmsMetadataObjectType);
                                context.put("objectName", rset.getString(1));
                                /* Source code is scraped into subdirectories SCHEMA/OBJECTTYPE
                                   All PLDoc is generated into the Schema directory,i.e. the PLDoc
                                   is one directory above.
                                */
                                context.put("pldocPath"
                                           , "../".concat(getPLDocFileName(inputSchemaName
					                              ,dbmsMetadataObjectType
                                                                      ,rset.getString(1)
                                                                      )
                                                        )
                                        );

				bufferedReader =  
				new  BufferedReader(
				  new  SourceCodeScraper(
				      dbmsMetadata.getDdl(dbmsMetadataObjectType,
							  rset.getString(1),
							  inputSchemaName,
							  "COMPATIBLE",
							  "ORACLE",
							  "DDL"
						       ) 
				    ,savedSourceFileWriter
				    ,false
				    ,"sourcecode.xsl"
                                    ,context
				  )
				)
				;
			     }
			     else
			     {
				bufferedReader =  
				new  BufferedReader(
				      dbmsMetadata.getDdl(dbmsMetadataObjectType,
							  rset.getString(1),
							  inputSchemaName,
							  "COMPATIBLE",
							  "ORACLE",
							  "DDL"
						       ) 
				)
				;
			     }


			    final Throwable throwable = processPackage(
				 bufferedReader 
			      ,xmlOut, packagename
			      ,inputSchemaName 
			      , ("_" + inputSchemaName) // ("-" + inputSchemaName + " Schema Level" ) //SRT 20110503 //"_GLOBAL" //SRT 20110418
			    );

			  // Test the processing result
			  if (throwable == null) {
			    processedPackages++;
			  } else {
			    skippedPackages.put(packagename, throwable);
			  } 
			} 
			catch (SQLException sqlE)
			{
			    sqlE.printStackTrace(System.err);
			    skippedPackages.put(packagename, sqlE);
			}
			finally
			{
			      if (null != bufferedReader)
			      {
				bufferedReader.close();
				bufferedReader = null;  
			      }
			      if (null != savedSourceFileWriter)
			      {
				savedSourceFileWriter.flush();
				savedSourceFileWriter.close();
				savedSourceFileWriter = null ; 
			      }
			}
	  } while (rset.next());
		}
	    } finally  {
		if( rset != null ) rset.close();
	    }
	  }
	} /* Keep Connect for PLSCOPE extract */
	    finally {
	    if( pstmt != null ) pstmt.close();
	    //if ( conn != null ) conn.close();
	} 
      } // for all the specified packages from the dictionary

      // @TODO output synonyms 
      // generator summary
      xmlOut.startElement("GENERATOR");

      // objects like files or database objects
      xmlOut.startElement("OBJECTS");
      // save count processed objects
      xmlOut.pushAttribute("COUNT", String.valueOf(processedPackages));
      xmlOut.startElement("PROCESSED");
      xmlOut.endElement("PROCESSED");

      // save errors
      xmlOut.pushAttribute("COUNT", String.valueOf(skippedPackages.size()));
      xmlOut.startElement("SKIPPED");
      if (settings.isShowSkippedPackages()) {
        for (Iterator iter = skippedPackages.keySet().iterator(); iter.hasNext();) {
          final String packagename = (String) iter.next();
          final String error = ((Throwable) skippedPackages.get(packagename)).getLocalizedMessage();
          xmlOut.pushAttribute("ERROR", error);
          xmlOut.pushAttribute("NAME", packagename);
          xmlOut.startElement("OBJECT");
          xmlOut.endElement("OBJECT");
        }
      }
      xmlOut.endElement("SKIPPED");
      xmlOut.endElement("OBJECTS");

      // save creation date and time
      final Date date = new Date();
      final String creationdate = DateFormat.getDateInstance(DateFormat.SHORT).format(date);
      final String creationtime = DateFormat.getTimeInstance(DateFormat.SHORT).format(date);
      xmlOut.pushAttribute("DATE", creationdate);
      xmlOut.pushAttribute("TIME", creationtime);
      xmlOut.startElement("CREATED");
      xmlOut.endElement("CREATED");

      xmlOut.pushAttribute("VERBOSE",   settings.isVerbose() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("SHOW_SKIPPED_PACKAGES",   settings.isShowSkippedPackages() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("IGNORE_INFORMAL_COMMENTS",   settings.isIgnoreInformalComments() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("INPUT_ENCODING",   settings.getInputEncoding() );
      xmlOut.pushAttribute("DEFAULT_NAMES_CASE",   settings.getDefaultNamescase().toUpperCase() );
      xmlOut.pushAttribute("DEFAULT_KEYWORDS_CASE",   settings.getDefaultKeywordscase().toUpperCase() );
      xmlOut.pushAttribute("NAMES_TO_DEFAULT_CASE",   settings.isNamesDefaultcase() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("NAMES_TO_UPPER_CASE",   settings.isNamesUppercase() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("NAMES_TO_LOWER_CASE",   settings.isNamesLowercase() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("KEYWORDS_TO_DEFAULT_CASE",   settings.isKeywordsDefaultcase() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("KEYWORDS_TO_UPPER_CASE",   settings.isKeywordsUppercase() ? "TRUE" : "FALSE"  );
      xmlOut.pushAttribute("KEYWORDS_TO_LOWER_CASE",   settings.isKeywordsLowercase() ? "TRUE" : "FALSE"  );
      xmlOut.startElement("SETTINGS");
      xmlOut.endElement("SETTINGS");

      xmlOut.endElement("GENERATOR");

      xmlOut.endElement("APPLICATION");

      // All Nodes of the type PACKAGE with the same name will be collapsed to one node
      // This is necessary to put all global defined functions/procedures/triggers into one
      // big dummy package _GLOBAL.
      collapseSimilarNodes(xmlOut.getDocument(), "PACKAGE", new String[] {"SCHEMA", "NAME"} );
      //SRT Work In Progress collapseSimilarNodes(xmlOut.getDocument(), "TRIGGER", "SCHEMA" ); //111G Triggers have been moved up to Schema Level 

      xmlOut.endDocument();
    } catch(FileNotFoundException e) {
      System.err.println("File cannot be created: " + applicationFile);
      e.printStackTrace();
      throw new SystemExitException();
    } finally {
      if(output != null) {
        output.close();
      }
    }


    // copy required static files into the output directory
    copyStaticFiles(settings.getOutputDirectory());

    
    //If we are connected to the database extract any synonyms 
    if ( conn != null ) {
      extractSynonyms(conn, synonymStatement, objectSchemas, synonymsFile); 
    }

    //If we are connected to the database and want PLScope , extract PLSCOPE 
    if ( conn != null  && settings.isPlscope() ) {
        
      try {
  	    File mergedFile = new File (settings.getOutputDirectory(), "application-plscope.xml" ) ;
        try {
            extractPLscope(conn, plscopeQueries, applicationFile, mergedFile); 
        }
        catch (Exception e)
        {
          if (dictionaryViewsHaveReverted )
          {
            throw new Exception ("Failed to extract PLScope" ,e ); //Pass problem up 
          }
          else//Revert to ALL_OBJECTS  
          {
            dictionaryViewsHaveReverted = true ; 

            //Adjust plscope settings to use ALL_* dictionary views 
            plscopeQueries = plscopeQueriesMap.get("ALL_");  
            extractPLscope(conn, plscopeQueries, applicationFile, mergedFile); 
          }
      }


  	   //Use the merged file rather than the originally generated application.xml
  	   applicationFile = mergedFile ;
    	}
    	finally { //Close Any remaining output 
    	    if( pstmt != null ) pstmt.close();
    	    if ( conn != null ) conn.close();
    	} 
    }


    // generate HTML files from the applicationFile and any synonyms 
    generateHtml(applicationFile, synonymsFile);

    // write skipped packagenames to console
    if (!skippedPackages.isEmpty()) {
      System.err.println("Following packages were skipped due to errors:");
      for (Iterator iter = skippedPackages.keySet().iterator(); iter.hasNext();) {
        final String packagename = (String) iter.next();
        System.err.print(packagename);
        if (iter.hasNext()) {
          System.err.print(", ");
        }
      }
      System.err.println();
      System.err.println(skippedPackages.size()+" packages skipped!");
    }

    // successfully processed packages
    System.out.println(""+processedPackages+" packages processed successfully.");
  }

  
  /**
  * Write ResultSet to Output As XML using the specified settings.
  *
  *@param resultSet the database information to write 
  *@param outputStream outputStream
  *@param documentRootName the root Element of the XML document 
  *@param rowElementName the element containing each row document 
  *@param dtd Optional DTD that the XML should validate against  
  *
  *@throws Exception on error 
  */
  public void resultSetToXml(ResultSet resultSet, OutputStream outputStream, String documentRootName, String rowElementName, String dtd ) throws Exception
  {
    try {

      ResultSetMetaData resultSetMetaData = resultSet.getMetaData(); 
      XMLWriter xmlOut = new XMLWriter(outputStream);
      xmlOut.setMethod("xml");
      if (settings.getOutputEncoding() != null)
        xmlOut.setEncoding(settings.getOutputEncoding());
      xmlOut.setIndent(true);
      if (null!=dtd && !dtd.equals("")) { xmlOut.setDocType(null, dtd); }
      xmlOut.startDocument();
      //xmlOut.pushAttribute("NAME", );
      xmlOut.startElement(documentRootName);

      int numberOfColumns = resultSetMetaData.getColumnCount();

      // for all rows 
      while (resultSet.next()) {
	      //Attributes are pushed before the containing Element is created  
	      for (int i = 1 ; i <= numberOfColumns; i++ )
	      {
		 xmlOut.pushAttribute(resultSetMetaData.getColumnName(i), resultSet.getString(i) );
	      }
	      xmlOut.startElement(rowElementName);
	      xmlOut.endElement(rowElementName);
      }


      xmlOut.endElement(documentRootName);

      xmlOut.endDocument();
    } finally {
      if(outputStream != null) {
        outputStream.close();
      }
    }

  }

  
  /**
  * Processes a package.
  *
  * 2006-05-16 - Matthias Hendler - Rewritten exception handling and methode signature.
  *
  * @param packageSpec  Package specification to parse
  * @param xmlOut       XML writer
  * @param pPackageName The name of the package which is processed
  * @param pSchemaName  The name of the package owner 
  * @param pGlobalPackageName The name of the default package name to contain function, procedure and trigger PLDoc if pSchemaName is not provided
  * @return             Null, if successfully processed or otherwise throwable which was encountered during processing.
  * @throws SystemExitException   Thrown if an error occurred and the user specified the halt on errors option.
  *                               All other throwables will be caught.
  */

  public Throwable processPackage(BufferedReader packageSpec, XMLWriter xmlOut, String pPackageName
		                   , String pSchemaName, String pGlobalPackageName
				  )
      throws SystemExitException
  {
    Throwable result = null;
    SubstitutionReader input = null;
    try {
      input = new SubstitutionReader(packageSpec, settings.getDefines());

      // parse the input file
      PLSQLParser parser = new PLSQLParser(input);

      // start writing new XML for the input file
      XMLWriter outXML = new XMLWriter();
      outXML.startDocument();
      outXML.startElement("FILE");

      // set parser params
      parser.setXMLWriter(outXML);
      parser.setIgnoreInformalComments(settings.isIgnoreInformalComments());
      parser.setDefaultNamescase(settings.getDefaultNamescase());
      parser.setDefaultKeywordscase(settings.getDefaultKeywordscase());
      parser.setNamesDefaultcase(settings.isNamesDefaultcase());
      parser.setNamesUppercase(settings.isNamesUppercase());
      parser.setNamesLowercase(settings.isNamesLowercase());
      parser.setKeywordsDefaultcase(settings.isKeywordsDefaultcase());
      parser.setKeywordsUppercase(settings.isKeywordsUppercase());
      parser.setKeywordsLowercase(settings.isKeywordsLowercase());
      if (null != pSchemaName) parser.setSchemaName(pSchemaName); //SRT 20110418
      if (null != pGlobalPackageName) parser.setGlobalPackageName(pGlobalPackageName); //SRT 20110418
       

      
      // run parser
      parser.input();

      outXML.endElement("FILE");
      outXML.endDocument();

      // file parsed successfully
      // append all nodes below FILE to the main XML
      xmlOut.appendNodeChildren(outXML.getDocument().getDocumentElement());
    } catch(ParseException e) {
      System.err.println("ParseException at package <"+pPackageName+">: "+e);
      System.err.println("Last consumed token: \"" + e.currentToken + "\"");
      e.printStackTrace(System.err);
      // exit with error only if specifically required by user
      if (settings.isExitOnError()) {
        throw new SystemExitException(e);
      }
      System.err.println("Package " + pPackageName + " skipped.");
      result = e;
    } catch (Throwable t) {
      // Parser can cause errors which we also want to skip
      System.err.println("Throwable at package <"+pPackageName+">: "+t);
      t.printStackTrace(System.err);
      if (settings.isExitOnError()) {
        throw new SystemExitException(t);
      }
      System.err.println("Package " + pPackageName + " skipped.");
      result = t;
    } finally {
      try {
        if(input != null) {
          input.close();
        }
      } catch (IOException ioe) {
        System.err.println("Can't close input stream! Ignored!");
        System.err.println("IOException: "+ioe);
      }
    }

    return result;
  }

  /*
  * Helper method to return fixed resources to alternative applications
  */
  public static InputStream getResourceStream(String path) throws java.io.IOException {
      return resLoader.getResourceStream(path);
  }

 /*
  * Helper method to return fixed URIResolver to alternative applications
  */
  public static URIResolver getResourceResolver() {
      return resResolver;
  }

  /**
  * Reads the text from the overview file.
  *
  * @param overviewFile  The overview file to read from
  */
  private String getOverviewFileContent(File overviewFile) throws IOException {
    StringBuffer overview = new StringBuffer("");

    try {
      BufferedReader overviewReader =
        new BufferedReader(
          new InputStreamReader(
		 Utils.getBOMInputStream(new FileInputStream(settings.getOverviewFile())
				, settings.getInputEncoding()
				)
            ,settings.getInputEncoding())
        );
      String line = null;
      while ((line = overviewReader.readLine()) != null) {
        overview.append(line);
        overview.append("\n"); // use Java nre line instead as 0d0a will add additonal line feeds to output 
      }
      overviewReader.close();
    } catch(FileNotFoundException e) {
      System.err.println("File not found: " + settings.getOverviewFile());
      throw e;
    } catch(UnsupportedEncodingException e) {
      throw new IOException(e.toString());
    }

    // extract the text between <BODY> and </BODY>
    int start = overview.toString().toUpperCase().lastIndexOf("<BODY>");
    if (start != -1)
      overview.delete(0, start + 6);
    int end = overview.toString().toUpperCase().indexOf("</BODY>");
    if (end != -1)
      overview.delete(end, overview.length());

    return overview.toString();
  }


  private String getStringFromInputStream(InputStream inputStream) throws IOException  
   {
	byte[] inputBuffer = new byte[1024];
	StringBuffer stringBuffer = new StringBuffer(1024);

	    int bytesRead;
	    while (inputStream.available() > 0) {
		bytesRead = inputStream.read(inputBuffer);
		stringBuffer.append(new String(inputBuffer, 0, bytesRead));
	    }
	    if (settings.isVerbose())
		System.out.println("String derived from inputStream: \"" + 
		 stringBuffer + "\"");

        return stringBuffer.toString(); 
  }



  private void extractPLscope(Connection conn , Map<String,String> plscopeQueries, File applicationFile , File mergedFile ) 
  throws java.io.FileNotFoundException, java.io.IOException, java.sql.SQLException  
         ,javax.xml.transform.TransformerConfigurationException ,javax.xml.transform.TransformerException
         ,Exception
  {
      PreparedStatement pstmt = null;
    
      //Generate identifiers 
      String signaturesQueryPath = plscopeQueries.get("SIGNATURES");
      String callsQueryPath = plscopeQueries.get("CALLS");

      String plscopeQuery = getStringFromInputStream( getResourceStream(signaturesQueryPath) ) ;
      pstmt = conn.prepareStatement( plscopeQuery );

      ResultSet resultSet = pstmt.executeQuery();

      OutputStream outputStream = new FileOutputStream( new File (settings.getOutputDirectory(), "plscope_identifiers.xml")); 

      resultSetToXml(resultSet, outputStream, "PLSCOPE", "IDENTIFIER", null) ;

      //Extract the Calls 
      plscopeQuery = getStringFromInputStream( getResourceStream(callsQueryPath) ) ;
      pstmt = conn.prepareStatement( plscopeQuery );

      resultSet = pstmt.executeQuery();

      outputStream = new FileOutputStream( new File (settings.getOutputDirectory(), "plscope.xml")); 

      resultSetToXml(resultSet, outputStream, "PLSCOPE", "CALL", null) ;


      File signatureFile = new File (settings.getOutputDirectory(), "application-signatures.xml") ;

      //Merge PL/Scope calling information into Application XML 
      {
	 System.out.println("Merging PLDoc and PL/Scope XML files ...");
	      TransformerFactory tFactory = TransformerFactory.newInstance();
	      //tFactory.setURIResolver(resResolver);
	      Transformer transformer;
	      transformer = tFactory.newTransformer(new StreamSource( resLoader.getResourceStream("xslt/pldoc_merge_plscope_signatures.xslt")));
	      //Have to pass in Absolute location of output directory in order to avoid problems with redirect File locations when called from PLDocTask
	      transformer.setParameter("targetFolder", settings.getOutputDirectory().getAbsolutePath() + File.separator );
	      transformer.setParameter("plscopeDocument", new File( settings.getOutputDirectory() ,  "plscope_identifiers.xml")  );
	      transformer.setParameter("pldocDocument", applicationFile  );
	      transformer.transform(new StreamSource(applicationFile), new StreamResult(new FileOutputStream( signatureFile) ) );

	      transformer = tFactory.newTransformer(new StreamSource( resLoader.getResourceStream("xslt/pldoc_merge_plscope_calls.xslt")));
	      //Have to pass in Absolute location of output directory in order to avoid problems with redirect File locations when called from PLDocTask
	      transformer.setParameter("targetFolder", settings.getOutputDirectory().getAbsolutePath() + File.separator );
	      transformer.setParameter("plscopeDocument", new File( settings.getOutputDirectory() ,  "plscope.xml")  );
	      transformer.setParameter("pldocDocument", signatureFile );
	      transformer.transform(new StreamSource(signatureFile), new StreamResult(new FileOutputStream( mergedFile) ) );

      }

  }

  private void extractSynonyms(Connection conn , String synonymsQuery, Map<String,Integer> objectSchemas, File synonymsFile ) 
  throws java.io.FileNotFoundException, java.io.IOException, java.sql.SQLException  
         ,Exception
  {
      
      final String documentRootName = "SYNONYMS" ;
      final String rowElementName = "SYNONYM" ;
      PreparedStatement pstmt = null;
      OutputStream outputStream = null ;

      try
      {
	pstmt = conn.prepareStatement( synonymsQuery );

	outputStream = new FileOutputStream( synonymsFile ) ; 

	XMLWriter xmlOut = new XMLWriter(outputStream);
	xmlOut.setMethod("xml");
	if (settings.getOutputEncoding() != null)
        {
	  xmlOut.setEncoding(settings.getOutputEncoding());
        }
	xmlOut.setIndent(true);
	//SRT if (null!=dtd && !dtd.equals("")) { xmlOut.setDocType(null, dtd); }
	xmlOut.startDocument();
	//xmlOut.pushAttribute("NAME", );
	xmlOut.startElement(documentRootName);

	for (String objectSchema : objectSchemas.keySet() )
	{
	  pstmt.setString(1, objectSchema);
	  ResultSet resultSet = pstmt.executeQuery();
	  ResultSetMetaData resultSetMetaData = resultSet.getMetaData(); 

	  int numberOfColumns = resultSetMetaData.getColumnCount();

	  // for all rows 
	  while (resultSet.next()) {
		  //Attributes are pushed before the containing Element is created  
		  for (int i = 1 ; i <= numberOfColumns; i++ )
		  {
		     xmlOut.pushAttribute(resultSetMetaData.getColumnName(i), resultSet.getString(i) );
		  }
		  xmlOut.startElement(rowElementName);
		  xmlOut.endElement(rowElementName);
	  }

	} 
        xmlOut.endElement(documentRootName);

        xmlOut.endDocument();
      } finally {
	if(outputStream != null) {
	  outputStream.close();
	}
      }
  }


  /**
  * Generates HTML files from the provided XML file.
  *
  * 2006-05-16 - Matthias Hendler - Generates now a generator summary page, deprecated list and index list.
  *
  * @param applicationFile  XML application file
  */
  private void generateHtml(File applicationFile, File synonymsFile) throws Exception {
    // apply xsl to generate the HTML frames
    System.out.println("Generating HTML files ...");
    TransformerFactory tFactory = TransformerFactory.newInstance();
    tFactory.setURIResolver(resResolver);
    Transformer transformer;
    // list of schemas
    System.out.println("Generating allschemas.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("allschemas.xsl")));
    //Have to pass in Absolute location of output directory in order to avoid problems with redirect File locations when called from PLDocTask
    transformer.setParameter("targetFolder", settings.getOutputDirectory().getAbsolutePath() + File.separator );
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        //settings.getOutputDirectory().getPath() + File.separator + "allschemas.html"
	new File (settings.getOutputDirectory(), "allschemas.html")
	)));
    // summary
    System.out.println("Generating summary.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("summary.xsl")));
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        settings.getOutputDirectory().getPath() + File.separator + "summary.html")));
    // summary generator
    System.out.println("Generating generator.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("generator.xsl")));
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        settings.getOutputDirectory().getPath() + File.separator + "generator.html")));
    // deprecated list
    System.out.println("Generating deprecated-list.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("deprecated-list.xsl")));
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        settings.getOutputDirectory().getPath() + File.separator + "deprecated-list.html")));
    // index list
    System.out.println("Generating index-list.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("index-list.xsl")));
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        settings.getOutputDirectory().getPath() + File.separator + "index-list.html")));
    // list of packages
    System.out.println("Generating allpackages.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("allpackages.xsl")));
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        settings.getOutputDirectory().getPath() + File.separator + "allpackages.html")));
    // index
    System.out.println("Generating index.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("index.xsl")));
    transformer.transform(new StreamSource(applicationFile),
      new StreamResult(new FileOutputStream(
        settings.getOutputDirectory().getPath() + File.separator + "index.html")));
    // description for each package; the DOMResult is actually ignored
    System.out.println("Generating <unit>.html ...");
    transformer = tFactory.newTransformer(new StreamSource(
      resLoader.getResourceStream("unit.xsl")));
    //Have to pass in Absolute location of output directory in order to avoid problems with spaces in paths
    transformer.setParameter("targetFolder", settings.getOutputDirectory().getAbsolutePath() + File.separator );
    if ( settings.isSaveSourceCode() ) // Generate links to source code 
    {
      transformer.setParameter("sourceRootFolder", '.' );
    }
    
    if (null != synonymsFile && synonymsFile.exists())
    {
      //transformer.setParameter("synonymsFile", synonymsFile.getAbsolutePath() );
      //transformer.setParameter("synonymsFile", synonymsFile.toURI().toString() );
      transformer.setParameter("synonymsFile", synonymsFile.getCanonicalPath() );
    }
    else
    {
      transformer.setParameter("synonymsFile", "");
    }

    transformer.transform(new StreamSource(applicationFile), new DOMResult());
  }


  /**
  * Copies required static files into the output directory.
  *
  * @param outputDirectory
  */
  private void copyStaticFiles(File outputDirectory) throws Exception {
    try {
      // Copy the stylesheet
      Utils.CopyStreamToFile(
        settings.getStylesheetFile(),
        new File(outputDirectory.getPath() + File.separator + "stylesheet.css"));
      // Copy the DTD
      Utils.CopyStreamToFile(
        resLoader.getResourceStream("application.dtd"),
        new File(outputDirectory.getPath() + File.separator + "application.dtd"));
      // Copy the sourcestylesheet
      Utils.CopyStreamToFile(
        settings.getSourceStylesheetFile(),
        new File(outputDirectory.getPath() + File.separator + "sourcestylesheet.css"));

      // Copy sourcecode.xsl to top-level directory
      Utils.CopyStreamToFile(
	resLoader.getResourceStream("sourcecode.xsl"),
        new File(outputDirectory.getPath() + File.separator + "sourcecode.xsl"));

    } catch(FileNotFoundException e) {
      System.err.println("File not found. ");
      e.printStackTrace();
      throw e;
    }
  }

 
  /**
   * Collapse all the nodes of specifed type with the same attribute values to one node.
   *
   * 2006-05-18 - Matthias Hendler - added
   * 2011-05-1r4- SRT - renamed and added 
   *
   * @param pDocument        The document to work on
   * @param pNodeName        The node name to collapse to one node
   * @param pAttributeNames  The attributes to identify duplicates 
   */
  private void collapseSimilarNodes(Document pDocument, String pNodeName, String[] pAttributeNames) {
      for (HashMap<String,String> values : findEqualNodesOnAttributes(pDocument, pNodeName, pAttributeNames)  ) {
          System.out.println("Collapsing all nodes of type <"+pNodeName+"> on attribute set "+values+".");
          collapseNodes(pDocument, pNodeName, values);
      }
  }


  /**
   * Collapse all the nodes in the document which have the given attribute names and values.
   *
   * 2006-05-18 - Matthias Hendler - added
   *
   * @param pDocument   document to work on
   * @param pNodeName   node name
   * @param pAttributes  attribute name and value pairs 
   */
  private void collapseNodes(Document pDocument, String pNodeName, Map<String,String> pAttributes) {
      Node supernode = null;
      final List remove = new LinkedList();
      final NodeList nl = pDocument.getElementsByTagName(pNodeName);
      for (int index = 0; index < nl.getLength(); index++) {
          final Node node = nl.item(index);
          if (node.hasAttributes()) {
              final NamedNodeMap attributes = node.getAttributes();
	      final HashMap<String,String> nodeAttributes = new HashMap<String,String>() ;
              for (Iterator<String> it = pAttributes.keySet().iterator(); it.hasNext();) {
                  String attributeName = it.next();
                  final Node attribute = attributes.getNamedItem(attributeName);
                  if (attribute != null) {
                      nodeAttributes.put(attributeName, attribute.getNodeValue()) ;
                  }
              }
	      /*
	       If the 2 Maps match:-
	       	If this is the first node, base all subsequent matches on this node, 
		otherwise collapse the current node 
	      */
	      if (pAttributes.equals(nodeAttributes)) {
		  if (supernode == null) {
		      supernode = node;
		  } else {
		      if (node.hasChildNodes()) {
			  final NodeList childs = node.getChildNodes();
			  for (int index2 = 0; index2 < childs.getLength(); index2++) {
			      final Node child = childs.item(index2);
			      final Node clone = child.cloneNode(true);
			      supernode.appendChild(clone);
			  }
		      }
		      remove.add(node);
		  }
	      }

          }
      }

      if (!remove.isEmpty()) {
          for (Iterator iter = remove.iterator(); iter.hasNext();) {
              final Node node = (Node) iter.next();
              node.getParentNode().removeChild(node);
          }
      }
  }


  /**
   * Find all the nodes with equal attributes and return the duplicated attribute sets.
   *
   * 2006-05-18 - Matthias Hendler - added
   *
   * @param pDocument   document
   * @param pNodeName   name of the element
   * @param pAttribute  name of the attribute
   * @return            List of attribute sets which were identical
   */
  private List<HashMap<String,String>> findEqualNodesOnAttributes(Document pDocument, String pNodeName, String[] pAttributes) {

      // Maintain a Unique List of ALL  Attribute Sets
      final Set<HashMap<String,String>> found = new HashSet<HashMap<String,String>>();

      // Maintain a Unique List of DUPLICATED Attribute Sets
      final Set<HashMap<String,String>> result = new HashSet<HashMap<String,String>>();

      final NodeList nl = pDocument.getElementsByTagName(pNodeName);
      for (int index = 0; index < nl.getLength(); index++) {
          final Node node = nl.item(index);
          if (node.hasAttributes()) {
              final NamedNodeMap attributes = node.getAttributes();

	      final HashMap<String,String> nodeAttributes = new HashMap<String,String>() ;
	      //Generate a Map using the keys of pAttributes 
              for (int a = 0 ; a < pAttributes.length ;  a++ )
	      {
		final Node attribute = attributes.getNamedItem(pAttributes[a]);
		if (attribute != null) {
		    nodeAttributes.put(pAttributes[a], attribute.getNodeValue() );
		}
              }

	      if (nodeAttributes != null) {

	          /* 
		  Only put duplicate nodeAttributes in the results

		  Ths first time that a nodeAttributes set is encountered, found is populated.
		  Subsequently, result(nodeAttributes) is (re)populated, overwriting any previous value.

		  The net result is that results.keys contains a unique set of only the duplicated attribute sets

		  */

		  if (found.contains(nodeAttributes)) {
		    result.add(nodeAttributes);
		  } else {
		    found.add(nodeAttributes);
		  } 
	      }
          }
      }

      return new ArrayList<HashMap<String,String>>(result);
  }


}
