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

package net.sourceforge.pldoc.cpd;

import java.io.*;
import java.util.*;
import java.text.DateFormat;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMResult;


import net.sourceforge.pmd.util.FileFinder;
import net.sourceforge.pmd.cpd.*;


import net.sourceforge.pldoc.parser.PLSQLParser;
import net.sourceforge.pldoc.parser.ParseException;
import net.sourceforge.pldoc.DbmsMetadata;
import net.sourceforge.pldoc.SourceCodeScraper;
import net.sourceforge.pldoc.Utils;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.NamedNodeMap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 * PL/SQL CPD documentation generator.
 * <p>
 *
 *
 * @author Stuart Turton
 * </p>
 */
public class CPD
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
  private static String programName = "PLDoc(CPD) version: " + Version.id();
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

  }


  
private Map<String, SourceCode> source = new TreeMap<String, SourceCode>();
private CPDListener listener = new CPDNullListener();
private Tokens tokens = new Tokens();
private MatchAlgorithm matchAlgorithm;


  // Helper objects for retrieving resources relative to the installation.
  //SRT public static final ResourceResolver resResolver = new ResourceResolver();
  //SRT public static final ResourceLoader resLoader = new ResourceLoader();

  // Runtime settings
  public Settings settings;

  /**
  * Constructor.
  * @param settings command-line parameteres 
  */
  public CPD(Settings settings)
  {
    this.settings = settings;
  }

  /** Runn CPD using command-line settings.
   *
   * @param args command-line parameteres 
   * @throws Exception on any error 
   */
  public static void main(String[] args) throws Exception
  {
    long startTime = System.currentTimeMillis();
    System.err.println("");
    System.err.println(programName);

    // process arguments
    Settings settings = new Settings();
    settings.processCommandString(args);
    CPD cpd = new CPD(settings);

    // start running
    try {
      //Collect all the Source
      cpd.run();
      
      //
      cpd.go();
      if (cpd.getMatches().hasNext()) {
          File outputFile = settings.getOutputFile();
          PrintStream outputStream = System.out;
          
          if (null != outputFile )
          {
              System.err.println("Outputting CPD to " + outputFile.getAbsolutePath());
              outputStream = new PrintStream(new FileOutputStream(outputFile));
          }

          outputStream.println(settings.renderer().render(cpd.getMatches()));
          
          File stylesheet = settings.getStylesheet() ;
          if (null != outputFile
              // && null != stylesheet
              && "xml".equalsIgnoreCase(settings.getFormatString())
             )
          {
              System.err.println("Generating CPD HTML to " + outputFile.getAbsolutePath());
             settings.generateHtml(outputFile);
          }
          System.exit(0);
      }
    } catch (SystemExitException e) {
      System.exit(-1);
    }

    long finishTime = System.currentTimeMillis();
    System.err.println("Done (" + (finishTime-startTime)/1000.00 + " seconds).");
  }

  /**
  * Run CPD using the current settings.
  *
  * 2006-05-16 - Matthias Hendler - Collect some status information during the processing
  *                                 and add them to the application.xml.
  *                                 More verbose output to console added.
  * @throws Exception on any error 
  */
  public void run() throws Exception
  {
    long startTime = System.currentTimeMillis();
    // Map with all the packages (like files or database objects) which were skipped
    final SortedMap skippedPackages = new TreeMap();
    // Counts all the packages (like files or database objects) which were processed successfully
    long processedPackages = 0;

            // open the input file
    if (settings.isVerbose() ) System.out.println("Run() ");

    // if the output directory do not exist, create it
    if (!settings.getOutputDirectory().exists()) {
      System.err.println("Directory \"" + settings.getOutputDirectory() + "\" does not exist, creating ...");
      settings.getOutputDirectory().mkdir();
    }

    // open the output file (named application.xml)
    try {

      // for all the input files
              // open the input file
      if (settings.isVerbose() ) System.out.println("Parsing files ...");

      Iterator it = settings.getInputFiles().iterator();
      while (it.hasNext()) {
        String inputFileName = (String) it.next();
        final String packagename = inputFileName;

        // open the input file
        if (settings.isVerbose() ) System.err.println("Parsing file " + inputFileName + " ...");

        try {
          if (settings.isVerbose() ) 
	  {
	  	System.err.println("Processing : " + inputFileName + " as inputEncoding=\"" + settings.getInputEncoding() 
	                     +"\""
	                    );
	  }

          add(
	      new File(inputFileName)
             );

        } catch(FileNotFoundException e) {
          System.err.println("File not found: " + inputFileName);
          throw new SystemExitException(e);
        }
      } // for all the input files.
        // open the input file
      if (settings.isVerbose() ) System.err.println("Finished parsing files.");


      // open the database object 
      if (settings.isVerbose() ) System.err.println("Parsing database source ...");

      // for all the specified packages from the dictionary
      if ( settings.getDbUrl() != null && settings.getDbUser() != null && settings.getDbPassword() != null ) {
        // Load the Required JDBC driver class.
        // DriverManager.registerDriver(new OracleDriver());
	Class.forName(settings.getDriverName());

        Connection conn = null;
        PreparedStatement pstmt = null;

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
			 typeList =  "'PACKAGE','TYPE','PROCEDURE','FUNCTION','TRIGGER','PACKAGE BODY','TYPE BODY'"  ;
		  }


		  String sqlStatement = "SELECT  object_name"+
                                        ", object_type"+
                                        " FROM dba_objects"+
                                        " WHERE owner = ?"+
                                        " AND   object_name LIKE ?"+
                                        " AND  object_type in (" + typeList + ")"+
                                        " ORDER BY "+
                                        " object_name"
                                        ;
		   if (settings.isVerbose() ) System.err.println("Using \"" + sqlStatement + "\"" );

		   if (settings.isVerbose() ) System.err.println("Connecting ..");
           conn = DriverManager.getConnection( settings.getDbUrl(), settings.getDbUser(), settings.getDbPassword() );
		   if (settings.isVerbose() ) System.err.println("Connected");


          //Attempt to use DBA_OBJECTS, reverting to ALL_OBJECTS on any error
          pstmt = conn.prepareStatement(sqlStatement);


  	  //Use this path to generate relative paths from any extracted source paths, escaping any Windows directory separators
          String outputRootPath = settings.getOutputDirectory().getCanonicalPath();
          String outputRootPathRegExp = outputRootPath.replaceAll("\\\\","\\\\\\\\");

          DbmsMetadata dbmsMetadata = new DbmsMetadata(conn,settings.getGetMetadataStatement(), settings.getReturnType());

          it = settings.getInputObjects().iterator();
          while (it.hasNext()) {
            String input[] = ((String) it.next()).split("\\."); /* [ SCHEMANAME . ] OBJECTNAME */

			if ( input.length == 0 || input.length > 2 )
			{
			continue;
			}

            String inputSchemaName = ( input.length == 2 ? input[0] : settings.getDbUser() );
            String inputObjectName = ( input.length == 2 ? input[1] : input[0] );

            // get the object name(s)
	    ResultSet rset = null;

	    try {
		pstmt.setString(1, inputSchemaName);
		pstmt.setString(2, inputObjectName);

		try
		{
		  rset = pstmt.executeQuery();
		}
		catch (Exception e)
		{ //Revert to ALL_OBJECTS  
		  sqlStatement = sqlStatement.replaceFirst(" dba_", " all_");
		  if (settings.isVerbose() ) System.out.println("Reverting to \"" + sqlStatement + "\"" );
		  pstmt = conn.prepareStatement(sqlStatement);
		  pstmt.setString(1, inputSchemaName);
		  pstmt.setString(2, inputObjectName);
		  rset = pstmt.executeQuery();
		}

		// If the object is not present return false
		if (!rset.next()) {
		    // package does not exist

		    System.err.println("Object(s) like " + inputSchemaName + "." + inputObjectName + " do not exist or " + settings.getDbUser() + " does not have enough permissions (SELECT_CATALOG_ROLE role).");
		} else {
		    do {
			  final String objectName = rset.getString(1);
			  final String objectType = rset.getString(2);
			  //Remap DBA_OBJECTS.OBJECT_TYPE column contents to DBMS_METADATA.GET_DDL(OBJECT_TYPE) parameter if necessary
			  final String dbmsMetadataObjectType = hashMap.containsKey(rset.getString(2)) ? (String) hashMap.get(objectType) : objectType;

			  final String fullyQualifiedObjectName = inputSchemaName + "." + objectName;
			  if (settings.isVerbose() ) System.err.println("Parsing " + objectType + " name " + fullyQualifiedObjectName + " ...");

			  if (settings.isVerbose() ) System.err.println("Extracting DBMS_METADATA DDL for (object_type,object_name,schema)=(" 
                                                                       + objectType 
                                                                       + "," +objectName 
                                                                       + "," +inputSchemaName 
                                                                       + ") ..."
                                                                     );

			//Refresh static files if there directory  has not yet been modified in this run 
			if (startTime >= settings.getOutputDirectory().lastModified())
			{
			   // copy required static files into the source code directory
			   Utils.copyStaticRootDirectoryFiles(settings.getOutputDirectory(),  settings.getStylesheet() , settings.getSourceStylesheet() );
			   if (settings.isVerbose() ) System.err.println("Refreshed static files in " + settings.getOutputDirectory().getCanonicalPath() );
			}

			final File savedSchemaDirectory = new File (settings.getOutputDirectory(),  inputSchemaName);
			if ( settings.isSaveSourceCode() )
			{
			  if ( !savedSchemaDirectory.exists() )
			  {
			    savedSchemaDirectory.mkdir();
			  }
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
			  //Refresh sattic files if ther directory existed previously but has not yet been modified in this run 
			  else if (startTime > savedObjectTypeDirectory.lastModified())
			  {
			     // copy required static files into the source code directory
			     Utils.copyStaticSourceDirectoryFiles(savedObjectTypeDirectory, "../../" );
			     if (settings.isVerbose() ) System.err.println("Refreshed static files in " + savedObjectTypeDirectory.getCanonicalPath() );
			  }
			}

			final File savedSourceFile = new File (savedObjectTypeDirectory,  rset.getString(1).replace(' ','_') + "." + fileSuffixMap.get(rset.getString(2)) + ".xml" );  

			FileWriter  savedSourceFileWriter = null; //Set only if needed 

			// Open the reader first to prevent failure to retrieve the source code
			// crashing the application
			 BufferedReader bufferedReader = null;  
			 Throwable throwable = null; 
			try {
			       if (settings.isSaveSourceCode() ) 
			       {
				  System.err.println("Saving DDL for (object_type,object_name,schema)=(" + dbmsMetadataObjectType + "," +rset.getString(1) + "," +inputSchemaName  + ") to "
						      + savedSourceFile.getCanonicalPath()
						      );
				savedSourceFileWriter = new FileWriter(savedSourceFile);  

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
				    ,null // No PLDoc for CPD 
				  )
				)
				;
			        //pass signature as path relative to output directory 
				throwable = add(
				    0
				    ,bufferedReader 
				    //Convert paths to relative paths, and remaining Windows directory separators to Unix separators 
				    ,savedSourceFile.getCanonicalPath().replaceFirst(outputRootPathRegExp,".").replaceAll("\\\\","/")
				);

			     }
			     else
			     {
			      bufferedReader =  
                              new BufferedReader(
                                dbmsMetadata.getDdl(dbmsMetadataObjectType,
						    rset.getString(1),
						    inputSchemaName,
						    "COMPATIBLE",
						    "ORACLE",
						    "DDL") 
				                 );
			      throwable = add(
				  0
				  ,bufferedReader 
				  ,objectName
				  ,inputSchemaName 
				  ,objectType 
			      );

			     }


                            
			  // Test the processing result
			  if (throwable == null) {
			    processedPackages++;
			  } else {
			    skippedPackages.put(fullyQualifiedObjectName, throwable);
			  } 
			} 
			catch (SQLException sqlE)
			{
			    sqlE.printStackTrace(System.err);
			    skippedPackages.put(fullyQualifiedObjectName, sqlE);
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
	} finally {
	    if( pstmt != null ) pstmt.close();
	    if ( conn != null ) conn.close();
	}
      } // for all the specified objects from the dictionary




    } catch(Exception e) {
      e.printStackTrace();
      throw new SystemExitException();
    } finally {
      }
            if (settings.isVerbose() ) System.err.println("Added  " 
                + tokens.size() + " Token(s) from "
                + source.size() + " Abstract Syntax Tree Source(s)."
            );
        if ( null == tokens || 0 == tokens.size() ) 
        {
            System.err.println("run(): no Abstract Syntax Trees to compare") ;
        }

    }
  
  

  
  
  /**
  * Set monitor that checks for Cut and Paste in processed source code.
  *
  * @param cpdListener  source code listener
  */



  public void setCpdListener(CPDListener cpdListener) {
        this.listener = cpdListener;
    }

  /**
  * Find matches in the provided source code using the current settings.
  *
  */

    public void go() {
        if (settings.isVerbose() ) System.err.println("Checking  " 
                + tokens.size() + " Token(s) from "
                + source.size() + " Abstract Syntax Tree Source(s)."
            );
        if ( null == tokens || 0 == tokens.size() ) 
        {
            System.err.println("go(): no Abstract Syntax Trees to compare") ;
        }
        else 
        {

            TokenEntry.clearImages();
            matchAlgorithm = new MatchAlgorithm(
                            source, tokens, 
                            settings.minimumTileSize(), 
                            listener
                            );
            matchAlgorithm.findMatches();
        }
    }

    public Iterator<Match> getMatches() {
        return matchAlgorithm.matches();
    }

    public void add(File file) throws IOException {
        Throwable throwable = add(1, file);
        
    }

    public void addAllInDirectory(String dir) throws IOException {
        addDirectory(dir, false);
    }

    public void addRecursively(String dir) throws IOException {
        addDirectory(dir, true);
    }

    public void add(List<File> files) throws IOException {
        for (File f: files) {
            add(files.size(), f);
        }
    }

    private void addDirectory(String dir, boolean recurse) throws IOException {
        if (!(new File(dir)).exists()) {
            throw new FileNotFoundException("Couldn't find directory " + dir);
        }
        FileFinder finder = new FileFinder();
        // TODO - could use SourceFileSelector here
        add(finder.findFilesFrom(dir, settings.filenameFilter(), recurse));
    }

    private Set<String> current = new HashSet<String>();

    private Throwable add(int fileCount, File file) throws IOException {
        String filePath = file.getCanonicalPath();
        if (settings.skipDuplicates()) {
            // TODO refactor this thing into a separate class
            String signature = file.getName() + '_' + file.length();
            if (current.contains(signature)) {
                System.err.println("Skipping " + file.getAbsolutePath() + " since it appears to be a duplicate file and --skip-duplicate-files is set");
                return null;
            }
            current.add(signature);
        }

        if (!filePath.equals(new File(file.getAbsolutePath()).getCanonicalPath())) {
            System.err.println("Skipping " + file + " since it appears to be a symlink");
            return null;
        }

        Throwable result = null;
        try
        {
            listener.addedFile(fileCount, file);
            SourceCode sourceCode = settings.sourceCodeFor(file);
            settings.tokenizer().tokenize(sourceCode, tokens);
            source.put(sourceCode.getFileName(), sourceCode);
            if (settings.isVerbose() ) System.err.println("Tokenized " + sourceCode.getFileName());

        }
        catch (Throwable t)
        {
            System.err.println("Throwable at object <"+ filePath +">: "+t);
            t.printStackTrace(System.err);
            if (settings.isExitOnError()) {
                throw new SystemExitException(t);
            }
            System.err.println("Package " + filePath + " skipped.");
            result = t;
        }
        return result;
    }



   /** Pass in Reader with database attributes to generate a signature pseudo-path for user friendly referencing.
    *
    * @param fileCount to match the equivalent file-based methods 
    * @param codeReader Source code content from a stream
    * @param objectName database object name 
    * @param schemaName database user/schema name 
    * @param objectType database object type 
    * @return caught and uncaught events
    * @throws IOException on read or write error 
   */
   private Throwable add(int fileCount
                    , Reader codeReader
                    , String objectName
		    , String schemaName
                    , String objectType
           ) 
           throws IOException {
            String signature = schemaName + '/' + objectType + '/' + objectName ;
        
        if (settings.isVerbose() ) System.err.println("Tokenizing database source code with pseudo-signature " + signature);
        return add (fileCount, codeReader, signature ); 
   }


   /** Pass in Reader with an associated File to generate a signature path for user friendly referencing.
    *
    *<b>N.B.The file does not have to exist nor contain the source code passed in the Reader: it may simply
    *be an abstract file system reference for duplicate code reporting.</b>
    *
    * @param fileCount to match the equivalent file-based methods 
    * @param file File system reference to  
    * @return independent processing 
    * @throws IOException on read or write error 
   */
   private Throwable add(int fileCount
                    , Reader codeReader
                    , File   file
           ) 
           throws IOException {
        
        return add (fileCount, codeReader, file.getCanonicalPath()  ); 
   }


   /** Pass in Reader with a signature pseudo-path for user friendly referencing.
    *
    * @param fileCount to match the equivalent file-based methods 
    * @param codeReader source code for examination 
    * @param signature user supplied signature to refence this source code 
    * @return independent processing 
    * @throws IOException on read or write error 
   */
   private Throwable add(int fileCount
                    , Reader codeReader
                    , String signature
           ) 
           throws IOException {

        if (settings.skipDuplicates()) {
            // TODO refactor this thing into a separate class
            if (current.contains(signature)) {
                System.err.println("Skipping " + signature + " since it appears to be a duplicate file and --skip-duplicate-files is set");
                return null;
            }
            current.add(signature);
        }

        Throwable result = null;

        try
        {
            if (settings.isVerbose() ) System.err.println("Tokenizing database source code " + signature);
            listener.addedFile(fileCount, new File(signature) ); //Fake a file 
            DatabaseCodeLoader codeLoader = new DatabaseCodeLoader(codeReader,signature);
            SourceCode sourceCode = new SourceCode(codeLoader);
            settings.tokenizer().tokenize(sourceCode, tokens);
            source.put(signature, sourceCode);
            if (settings.isVerbose() ) System.err.println("Tokenized database source code " + sourceCode.getFileName());
        }
        catch (IOException ioe)
        {
            result = ioe;
            if (settings.isVerbose() ) System.err.println("Problem tokenizing database source code " + signature);
            ioe.printStackTrace(System.err);
            
        }
        catch (Throwable t) 
        {
            System.err.println("Throwable for signature <"+ signature +">: "+t);
            t.printStackTrace(System.err);
            if (settings.isExitOnError()) {
                throw new SystemExitException(t);
            }
            System.err.println("Source Code " + signature + " skipped.");
            result = t;
        } 
        
        return result;
   }


}
