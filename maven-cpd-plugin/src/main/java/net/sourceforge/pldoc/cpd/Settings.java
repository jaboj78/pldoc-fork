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
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMResult;

import net.sourceforge.pmd.cpd.*;

/** Represents all settings for the program.
* Setting values may be received from command line options and/or defaulted.
* This class should not have side effects.
* @author Stuart Turton
*/
public class Settings
{
  // Default settings 
  private static final String GET_METADATA_STATEMENT_DEFAULT = 
	"BEGIN" +
	"\n  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', FALSE);" +
	"\n  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS', FALSE);" +
	"\n  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA. SESSION_TRANSFORM,'SQLTERMINATOR',true );" +
	"\n  :1 := DBMS_METADATA.GET_DDL(\n       :2 ,\n       :3 ,\n       :4 ,\n       :5 ,\n       :6 ,\n       :7 )  \n;" +
	"\nEND;" 
	;

  private static final String DRIVER_NAME_DEFAULT = "oracle.jdbc.OracleDriver";
  
  //CPD specific defaults
  public static final String CPD_RENDER_FORMAT_DEFAULT = "text";
  public static final String CPD_LANGUAGE_DEFAULT = "plsql";
  public static final int CPD_MINIMUM_TOKENS_DEFAULT = 50;

  
  // settings and their defaults
  private String applicationName = "MyApplication";
  private File outputDirectory = new File("." + File.separator);
  private File outputFile = null ;
  private File stylesheetFile = null ;
  private File sourcestylesheetFile = null ;
  private Collection inputFiles = new ArrayList();
  private Properties defines = null;
  // by default, assume system default encoding for all input files
  private String inputEncoding = System.getProperty("file.encoding");
  // we cannot yet set output encoding dynamically, because of XSLs
  private boolean exitOnError = false;
  private boolean verbose = false;
  private String driverName = DRIVER_NAME_DEFAULT ;
  private String getMetadataStatement = GET_METADATA_STATEMENT_DEFAULT ;
  private int    returnType = java.sql.Types.CLOB;
  private String dbUrl = null;
  private String dbUser = null;
  private String dbPassword = null;
  private Collection inputTypes = new ArrayList();
  private Collection inputObjects = new ArrayList();
  private boolean showSkippedPackages = false;
  private boolean savesourcecode = false;

  // CPD Settings 
  private String formatString = CPD_RENDER_FORMAT_DEFAULT;
  private String languageString = CPD_LANGUAGE_DEFAULT;
  private int minimumTileSize = CPD_MINIMUM_TOKENS_DEFAULT;
  private boolean skipDuplicates = false;
  private boolean ignoreComments = false;
  private boolean ignoreIdentifiers = false;
  private boolean ignoreLiterals = false;
  private Renderer renderer;
  private Language language;
	

  private static final String usage =
    "Arguments: [options] inputfile(s)\n" +
    "-verbose                  Verbose - report each object processed \n" +
    "-language <language>      Language expected in the source code [default: "+ CPD_LANGUAGE_DEFAULT  +" ]\n" +
    "-format <format>          Output format [default: "+ CPD_RENDER_FORMAT_DEFAULT +" ]\n" +
    "-ignorecomments           Ignore comments in code\n" +
    "-ignoreidentifiers        Ignore identifiers (variable names etc.) in code\n" +
    "-ignoreliterals           Ignore literals (constant values, strings etc.) in code\n" +
    "-minimumTokens            Minimum number of sequential tokens before declaring a match [default: " + CPD_MINIMUM_TOKENS_DEFAULT +" ]\n" +
    "-skipduplicates           Ignore duplicated files\n" +
    "-savesourcecode           Save read source code to file system\n" +
    "-inputencoding <enc>      Encoding used in the input files [default: operation system default encoding]\n" +
    "-outputfile <name>        output file name [default: standard output ] \n" +
    "-stylesheetfile <name>    stylesheet name (when <format> is xml) \n" +
    "-sourcestylesheetfile <name>    stylesheet name (when <format> is xml) \n" +
    "-exitonerror              Force program to exit when some input file cannot be processed\n" +
    "                          [by default, the file is skipped and processing continues]\n" +
    "-driver <JDBC class>      Name of JDBC driver class, for example oracle.jdbc.OracleDriver, com.edb.Driver, or org.postgresql.Driver [default: " + DRIVER_NAME_DEFAULT + "].\n" +
    "-getmetadata <String>     SQL 92 CallableStatement Statement that retrieves the object source (EnterpriseDB does not support Oracle BEGIN .. END statements) [default: Oracle DBMS_METADATA anonymous block ].\n" +
    "                          	Statement structure is (\"call\" and function are case sensitive} \"{ ? = call GET_SOURCE( ? ,  ? ,  ? ,  ? , ? , ? ) }\"  where GET_SOURCE(...) mimics \n" +
    "                          	\"{ <RESULT_SET> =  call DBMS_METADATA.GET_DDL( <object_type> ,  <object_name> ,  <schema_name> ,  'COMPATIBLE' , 'ORACLE' , 'DDL' ) }\" \n" +
    "-returntype <java.sql.Types.?>  number corresponding to java.sql.Types.CLOB (2005) or java.sql.Types.VARCHAR (12) [default: java.sql.Types.CLOB].\n" +
    "-url <database url>       Database URL, for example jdbc:oracle:thin:@HOST:PORT:SID, jdbc:oracle:thin:@HOST:PORT/SERVICE, jdbc:edb://HOST:PORT/DATABASE,\n" +
    "                          or jdbc:postgresql://HOST:PORT/DATABASE [default: none].\n" +
    "                          Required when generating from the Oracle dictionary.\n" +
    "-user <db schema>         Schema name.\n" +
    "                          Required when generating from the Oracle dictionary. The user name is\n" +
    "                          case sensitive since Oracle stores user/schema names like \"My schema\" (name wit \n" +
    "                          double quotes) as 'My schema' in the dictionary. Ordinary schema names\n" +
    "                          like scott are stored as 'SCOTT' (upper case).\n" +
    "-password <db password>   Password of the logon user.\n" +
    "                          Required when generating from the Oracle dictionary.\n" +
    "-types <object type(s)>   Comma separated list of object type(s) to generate documentation for.\n" +
    "                          Defaults to all procedural types (PACKAGES, TYPES, FUNCTIONS PROCEDURES).\n" +
    "-sql <object name(s)>     Comma separated list of object name(s) to generate documentation for.\n" +
    "                          Required when generating from the Oracle dictionary.\n" +
    "                          An object name is case sensitive (the same rules as described for schema\n" +
    "                          names apply).\n" +
    "                          An object name may be prepended by a schema name and may have SQL\n" +
    "                          wildcards.\n" +
    "                          When the object belongs to a different schema than the logon user (as specified by\n" +
    "                          the -user parameter), the logon user must have been granted the SELECT_CATALOG_ROLE role or the SELECT ANY DICTIONARY system privilege.\n" +
    "-showSkippedPackages      Show the skipped packages in the summary of the documentation (generator.html).\n" 
    ;

  /** Consume command line strings received by the main() method 
   * @param args Command-line arguments 
   * @throws Exception on error 
   */
  public void processCommandString(String args[]) throws Exception
  {
    if (args.length < 1) {
      System.out.println(usage);
      System.exit(0);
    }

    // Re-parse the argument string, to recognize strings with spaces inside.
    // list of arguments:
    ArrayList argumentList = new ArrayList();

    // concatenate all the arguments
    StringBuffer arguments = new StringBuffer();
    for(int i = 0; i < args.length; i++) {
      if(i > 0) {
        arguments.append(' ');
      }
      arguments.append(args[i]);
    }

    // parse into the argument list
    StreamTokenizer st = new StreamTokenizer(new StringReader(arguments.toString()));
    // reset syntax, because we do not want to parse numbers
    st.resetSyntax();
    // whitespace is space, tabs, and all symbols in between
    st.whitespaceChars('\t', ' ');
    // words consists of all possible characters above the space character
    st.wordChars(' ' + 1, '\u00FF');
    // two types of quote
    st.quoteChar('"');
    st.quoteChar('\'');
    while(st.nextToken() != StreamTokenizer.TT_EOF) {
      switch(st.ttype) {
        case StreamTokenizer.TT_WORD:
        case '"':
        case '\'':
          argumentList.add(st.sval);
        default:
          ; // ignore
      }
    }

    // process the argument list "semantically"
    Iterator it = argumentList.iterator();
    while(it.hasNext()) {
      String arg = (String) it.next();

      if (arg.equalsIgnoreCase("-ignorecomments")) {
        // consume  "-ignorecomments"
        this.ignoreComments = true;
      }
      else if (arg.equalsIgnoreCase("-ignoreidentifiers")) {
        // consume  "-ignoreidentifiers"
        this.ignoreIdentifiers = true;
      }
      else if (arg.equalsIgnoreCase("-ignoreliterals")) {
        // consume  "-ignoreliterals"
        this.ignoreLiterals = true;
      }
      else if (arg.equalsIgnoreCase("-skipduplicates")) {
        // consume  "-skipDuplicates"
        this.skipDuplicates = true;
      }
      else if (arg.equalsIgnoreCase("-language")) {
        // consume  "-language"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.languageString = (String) it.next();
      	//language = new LanguageFactory().createLanguage(languageString);      
      }
      else if (arg.equalsIgnoreCase("-format")) {
        // consume  "-format"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.formatString = (String) it.next();
        renderer = getRendererFromString(formatString);
      }
      else if (arg.equalsIgnoreCase("-minimumtokens")) {
        // consume  "-minimumtokens"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
	minimumTileSize = Integer.parseInt( (String) it.next() );
      }
      else if (arg.equalsIgnoreCase("-inputencoding")) {
        // consume  "-inputencoding"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.inputEncoding = (String) it.next();
      }
      else if (arg.equalsIgnoreCase("-verbose")) {
        // consume  "-verbose"
        this.verbose = true;
      }
      else if (arg.equalsIgnoreCase("-exitonerror")) {
        // consume  "-exitonerror"
        this.exitOnError = true;
      }
      else if (arg.equalsIgnoreCase("-returntype")) {
        // consume  "-returntype"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.returnType = Integer.parseInt((String) it.next());
      }
      else if (arg.equalsIgnoreCase("-driver")) {
        // consume  "-driver"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.driverName = (String) it.next();
      }
      else if (arg.equalsIgnoreCase("-getmetadata")) {
        // consume  "-getmetadata"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.getMetadataStatement = (String) it.next();
      }
      else if (arg.equalsIgnoreCase("-url")) {
        // consume  "-url"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.dbUrl = (String) it.next();
      }
      else if (arg.equalsIgnoreCase("-user")) {
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.dbUser = (String) it.next();
      }
      else if (arg.equalsIgnoreCase("-password")) {
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        this.dbPassword = (String) it.next();
      }
      else if (arg.equalsIgnoreCase("-sql")) {
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
	String inputObjectsList = (String)it.next();
        inputObjects = Arrays.asList(inputObjectsList.split(","));
      }
      else if (arg.equalsIgnoreCase("-types")) {
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
	String inputTypesList = (String)it.next();
        inputTypes = Arrays.asList(inputTypesList.split(","));
      }
      else if (arg.equalsIgnoreCase("-showskippedpackages")) {
        // consume  "-showskippedpackages"
        this.showSkippedPackages = true;
      }
      else if (arg.equalsIgnoreCase("-savesourcecode")) {
        // consume  "-showskippedpackages"
        this.savesourcecode = true;
      }
      else if (arg.equalsIgnoreCase("-stylesheetfile")) {
        // consume  "-stylesheetfile"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        stylesheetFile = new File((String) it.next()) ;
        // check the file
        if (!(stylesheetFile.exists())) {
          processInvalidUsage("The specified stylesheet file " + stylesheetFile + " does not exist !");
        }
      }
      else if (arg.equalsIgnoreCase("-sourcestylesheetfile")) {
        // consume  "-stylesheetfile"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
        sourcestylesheetFile = new File((String) it.next()) ;
        // check the file
        if (!(sourcestylesheetFile.exists())) {
          processInvalidUsage("The specified sourcestylesheet file " + sourcestylesheetFile + " does not exist !");
        }
      }
      else if (arg.equalsIgnoreCase("-outputfile")) {
        // consume  "-outputfile"
        if(!it.hasNext()) {
          processInvalidUsage("Option " + arg + " requires a value !");
        }
           String outputFileName = (String) it.next() ;
           if (null != outputFileName
               && !outputFileName.equals("")
               && !outputFileName.equals("-")
              )
           {
            outputFile = new File(outputDirectory + File.separator + outputFileName );
           }
      }
      else if (arg.startsWith("-")) {
        System.err.println("WARN - unknown parameter \""+arg+"\"");
        processInvalidUsage("Unknown option " + arg);
      } else {
        // no option code recognized - assume it's a file name
        inputFiles.add(arg);
      }

    }

    // the input file(s) OR object name(s) MUST be given
    if ((inputFiles.isEmpty() && inputObjects.isEmpty()) ||
        (!inputFiles.isEmpty() && !inputObjects.isEmpty())) {
      processInvalidUsage("Either input file name(s) or object name(s) must be given!");
    }

    // When object name(s) are supplied, the connect info must be supplied.
    if (!inputObjects.isEmpty() &&
	(this.dbUrl == null || this.dbUser == null || this.dbPassword == null)) {
      processInvalidUsage("Database url, db schema and db password are mandatory when object name(s) are supplied!");
    }
    
    //Set up the objects
    language = new LanguageFactory().createLanguage(this.languageString);
    renderer = getRendererFromString(this.formatString);

    //Pass all settings via System propeties 
    System.setProperty("ignore_comments", (ignoreComments ? "true" : "false") );
    System.setProperty("ignore_identifiers",(ignoreIdentifiers? "true" : "false")  );
    System.setProperty("ignore_literals",  (ignoreLiterals? "true" : "false")  );
  }

  public void setApplicationName(String applicationName) {
          this.applicationName = applicationName;
  }
  public void setOutputDirectory(File outputDirectory) {
          this.outputDirectory = outputDirectory;
  }
  public void setInputFiles(Collection inputFiles) {
          this.inputFiles = inputFiles;
  }
  public void setDefines(Properties defines) {
          this.defines = defines;
  }
  public void setInputEncoding(String inputEncoding) {
          this.inputEncoding = inputEncoding;
  }
  public void setVerbose(boolean verbose) {
          this.verbose = verbose;
  }
  public void setExitOnError(boolean exitOnError) {
          this.exitOnError = exitOnError;
  }
  public void setReturnType(int returnType) {
          this.returnType = returnType;
  }
  public void setDriverName(String driverName) {
          this.driverName = driverName;
  }
  public void setGetMetadataStatement(String getMetadataStatement) {
          this.getMetadataStatement = getMetadataStatement;
  }
  public void setDbUrl(String dbUrl) {
          this.dbUrl = dbUrl;
  }
  public void setDbUser(String dbUser) {
          this.dbUser = dbUser;
  }
  public void setDbPassword(String dbPassword) {
          this.dbPassword = dbPassword;
  }
  public void setInputObjects(Collection inputObjects) {
          this.inputObjects = inputObjects;
  }
  public void setInputTypes(Collection inputTypes) {
          this.inputTypes = inputTypes;
  }

  public void setShowSkippedPackages(boolean showSkippedPackages) {
    this.showSkippedPackages = showSkippedPackages;
  }

  public void setSaveSourceCode(boolean savesourcecode) {
    this.savesourcecode = savesourcecode;
  }

  public String getApplicationName() {
    return applicationName;
  }

  public File getOutputDirectory() {
    return outputDirectory;
  }

  public Collection getInputFiles() {
    return inputFiles;
  }

  public Properties getDefines() {
    return defines;
  }

  public String getInputEncoding() {
    return inputEncoding;
  }

  public boolean isVerbose() {
    return verbose;
  }

  public boolean isExitOnError() {
    return exitOnError;
  }

  public String getDbUrl() {
    return dbUrl;
  }

  public String getGetMetadataStatement() {
    return getMetadataStatement;
  }

  public int getReturnType() {
    return returnType;
  }

  public String getDriverName() {
    return driverName;
  }

  public String getDbUser() {
    return dbUser;
  }

  public String getDbPassword() {
    return dbPassword;
  }

  public Collection getInputObjects() {
    return inputObjects;
  }

  public Collection getInputTypes() {
    return inputTypes;
  }


  public boolean isShowSkippedPackages() {
    return showSkippedPackages;
  }

  public boolean isSaveSourceCode() {
    return savesourcecode;
  }

    public SourceCode sourceCodeFor(File file) {
    	return new SourceCode(
        	new SourceCode.FileCodeLoader(file, getInputEncoding())
			);
    }
    
    
    public Language language() { return language; }
    
    public int minimumTileSize() { return minimumTileSize; }
    
    public boolean skipDuplicates() { return skipDuplicates; }

    public void skipDuplicates(boolean flag) { skipDuplicates = flag; }
    
    public boolean ignoreComments() { return ignoreComments; }

    public void setLanguage(String languageString) { 
        
      this.languageString = languageString; 
    
    //Set up the objects
    
     /*
      * Explicitly set PLSQL Language to cope with ANT Loader problems 
      * Hopefully this problem should disappear if PLSQLLanguage is adopted into
      * the PMD/CPD source tree.
      */
     if (languageString.equalsIgnoreCase(CPD_LANGUAGE_DEFAULT))
     {
         language = new PLSQLLanguage();
     }
     else
     {
        language = new LanguageFactory().createLanguage(this.languageString);
     }
    }
    
    public void setLanguage(Language language) { 
        this.language  = language; 
    }
    
    public Language getLanguage() { return language; }
    
    public void setFormat(String formatString) { this.formatString = formatString; 
    renderer = getRendererFromString(this.formatString);
    }
    
    public void setFormat(Renderer renderer) { this.renderer = renderer; 
    }
    
    public Renderer getRenderer() { return renderer; }

    
    
    public void setIgnoreComments(boolean flag) { ignoreComments = flag; 
        System.setProperty("ignore_comments", (ignoreComments ? "true" : "false") );

    }
    
    public boolean ignoreIdentifiers() { return ignoreIdentifiers; 
    }

    public void setIgnoreIdentifiers(boolean flag) { ignoreIdentifiers = flag; 
    System.setProperty("ignore_identifiers",(ignoreIdentifiers? "true" : "false")  );
    }
    
    public boolean ignoreLiterals() { return ignoreLiterals; }

    public void setIgnoreLiterals(boolean flag) { ignoreLiterals = flag; 
    System.setProperty("ignore_literals",  (ignoreLiterals? "true" : "false")  );
    }

    public int getMinimumTileSize() { return minimumTileSize; }

    public void setMinimumTileSize(Integer minimumTileSize) { this.minimumTileSize = minimumTileSize; }
    
    public FilenameFilter filenameFilter() { return language.getFileFilter(); }
    
    public Tokenizer tokenizer() { 
                                     return language.getTokenizer(); 
                                 }
    
    public Renderer renderer() { return renderer; }

    /*
     * Cut and Pasted :-) from CPDConfiguration
     */
    public static Renderer getRendererFromString(String name /*, String encoding*/) {
        if (name.equalsIgnoreCase("text") || name.equals("")) {
            return new SimpleRenderer();
        } else if ("xml".equals(name)) {
            return new XMLRenderer();
        }  else if ("csv".equals(name)) {
            return new CSVRenderer();
        }  else if ("vs".equals(name)) {
            return new VSRenderer();
        }
        try {
            return (Renderer) Class.forName(name).newInstance();
        } catch (Exception e) {
            System.out.println("Can't find class '" + name + "', defaulting to SimpleRenderer.");
        }
        return new SimpleRenderer();
    }


  public void setOutputFile(String outputFileName) {
    outputFile = new File ( outputDirectory + outputFileName );
  }

  public void setOutputFile(File outputFile) {
    this.outputFile = outputFile;
  }

  public File getOutputFile() {
    return outputFile ;
  }

  public void setStylesheet(String stylesheetName) {
    stylesheetFile = new File ( stylesheetName );
  }
  
  public void setStylesheet(File stylesheetFile) {
    this.stylesheetFile =  stylesheetFile;
  }
  
  public File getStylesheet() {
    return stylesheetFile ;
  }

  public void setSourceStylesheet(String sourcestylesheetName) {
    sourcestylesheetFile = new File ( sourcestylesheetName );
  }
  
  public void setSourceStylesheet(File sourcestylesheetFile) {
    this.sourcestylesheetFile =  sourcestylesheetFile;
  }
  
  public File getSourceStylesheet() {
    return sourcestylesheetFile ;
  }

  public String getFormatString() {
    return formatString ;
  }

  public String getLanguageString() {
    return languageString ;
  }

  
  /**
  * Generates HTML file from the provided XML file and the specified stylesheet.
  *
  * @param outputFile CPD output file 
  * @throws Exception on error 
  */
  public void generateHtml(File outputFile) throws Exception {
    // apply xsl to generate the HTML frames
    final String outputFileName = outputFile.getAbsolutePath();
    final String fileExtension = ".XML";
    final String outputFileStem = (outputFileName.toUpperCase().endsWith(fileExtension))
                                   ? outputFileName.substring(0,outputFileName.length() - fileExtension.length())
				   : outputFileName;
    
    final String htmlFileName = outputFileStem + ".html" ;
    final String xsltFilePath =  "xslt/cpdhtml.xsl" ;
    
    TransformerFactory tFactory = TransformerFactory.newInstance();
    Transformer transformer;
    System.err.println("Generating HTML ...");
    System.err.println("... using " + xsltFilePath );
    InputStream inputStream = (new ResourceLoader()).getResourceStream( xsltFilePath ) ;
    if ( null == inputStream )  
    {
      System.err.println("Could not locate "+ xsltFilePath);
    }


    transformer = tFactory.newTransformer(new StreamSource( new InputStreamReader ( 
										     inputStream 
                                                                                     //new FileInputStream (stylesheetFile)
                                                                                     , inputEncoding
                                                                                  )
                                                         )
                                         );
    
    //Have to pass in Absolute location of output directory in order to avoid problems with redirect File locations when called from PLDocTask
    System.err.println("Generating CPD HTML from " + outputFileName + " to " + htmlFileName);
    
    transformer.setParameter("targetFolder", getOutputDirectory().getAbsolutePath() + File.separator );
    transformer.transform(new StreamSource(new InputStreamReader( CPDUtils.getBOMInputStream(new FileInputStream(outputFile)
					                                                     ,inputEncoding)
				                                  ,inputEncoding) 
			                  ),
      new StreamResult(new FileOutputStream(  htmlFileName  )
                      )
            );
  }
  
    
  /** Processes invalid usage: prints the error message and the usage instruction
  * and halts.
  */
  private void processInvalidUsage(String message) {
    System.out.println("Error: " + message);
    System.out.println(usage);
    System.exit(0);
  }

}

