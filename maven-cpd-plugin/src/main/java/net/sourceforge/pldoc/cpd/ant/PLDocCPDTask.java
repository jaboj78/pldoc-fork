package net.sourceforge.pldoc.cpd.ant;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Properties;
import net.sourceforge.pldoc.cpd.CPD;
import net.sourceforge.pldoc.cpd.CPDUtils;
import net.sourceforge.pldoc.cpd.Settings;
import net.sourceforge.pmd.cpd.Language;
import net.sourceforge.pmd.cpd.*;
import org.apache.tools.ant.*;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.Path;
import org.apache.tools.ant.types.Reference;

/**
 * PLDoc CPD Ant Task
 * <p>To define task in project:</p>
 * <pre>
 *   &lt;taskdef
 *     name="pldoc"
 *     classname="net.sourceforge.pldoc.cpd.ant.PLDocCPDTask"
 *     classpath="pldoc-pmd-plugin.jar" /&gt;
 * </pre>
 *
 * <p>To use:</p>
 * <pre>
 *   &lt;pldoc-cpd
 *     verbose = "yes" | "no" (default: "no")
 *     destdir = dir-path
 *     stylesheet = file-path (default: stylesheet from library)
 *     sourcestylesheet = file-path (default: stylesheet from library)
 *     inputEncoding = encoding (default: OS dependant) &gt;
 *     language = expected language (default: plsql) &gt;
 *     format = results format (default: text) &gt;
 *     inputEncoding = encoding (default: OS dependant) &gt;
 *     ignoreComments = (false | true) 
 *     ignoreIdentifiers = (false | true) 
 *     ignoreLiterals = (false | true) 
 *     minimumtokens =  integer
 *     showSkippedPackages = (false | true) 
 *     savesourcecode = (false | true) 
 *     url = text
 *     user = text
 *     password = text
 *     types = text
 *     sql = text
 *     &lt;!-- fileset+ --&gt;
 *     &lt;/pldoc&gt;
 *     driverName = text
 *     getMetadataStatement = text
 *     returntype = integer
 * </pre>
 * <p>Where:</p>
 * <dl>
 *  <dt>destdir</dt><dd>Directory to store documentation files (created if doesn't exist)</dd>
 *  <dt>stylesheet</dt><dd>File with CSS-stylesheet for the result documentation. If omitted, default CSS will be used.</dd>
 *  <dt>sourcestylesheet</dt><dd>File with CSS-stylesheet for ant saved source code. If omitted, default CSS will be used.</dd>
 *  <dt>inputEncoding</dt><dd>Input files encoding</dd>
 *  <dt>language</dt><dd>expected language</dd>
 *  <dt>format</dt><dd>output format</dd>
 *  <dt>ignoreComments</dt><dd> true if comment contents should be ignored when checking for matches.</dd>
 *  <dt>ignoreIdentifiers</dt><dd> true if object/variable names should be ignored when checking for matches.</dd>
 *  <dt>ignoreLiterals</dt><dd> true if character, string and numeric literal values should be ignored when checking for matches.</dd>
 *  <dt>minimumtokens</dt><dd> minimum number of tokens that constitues a match.</dd>
 *  <dt>showSkippedPackages</dt><dd>Display list of packages which failed to parse</dd>
 *  <dt>savesourcecode</dt><dd>Save read database source code to file system</dd>
 *  <dt>driverName</dt><dd>JDBC driver class to use to connect to the database</dd>
 *  <dt>url</dt><dd>Database connection URL</dd>
 *  <dt>user</dt><dd>Database username </dd>
 *  <dt>password</dt><dd>Database password</dd>
 *  <dt>types</dt><dd>Comma separated list of database types to parse from the database</dd>
 *  <dt>sql</dt><dd>Comma separated list of database objects to parse from the database</dd>
 *  <dt>fileset</dt><dd>Specifies files to be parsed. See <a href="http://ant.apache.org/manual/CoreTypes/fileset.html">Ant FileSet</a> for more details.</dd>
 *  <dt>getMetadataStatement</dt><dd>Callable statement to retrieve source text for each object, in this form "' ? = call GET_SOURCE( ? , ? , ? , ? , ? , ? ) '" </dd>
 *  <dt>getMetadataStatementReturnType</dt><dd>integer equal to java.sql.Types constant of the the object type returned by getMetadataStatement </dd>
 * </dl>
 */
public class PLDocCPDTask extends Task {
  //ANT 
  private Path classpath;
  private Path auxClasspath;
  private AntClassLoader antClassLoader;

  private Settings settings;
  private boolean m_verbose;
  private File m_destdir;
  private String m_doctitle;
  private File m_outputFile;
  private ArrayList m_filesets;
  private File m_stylesheet;
  private File m_sourcestylesheet;
  private char m_namesCase;
  private String m_inEnc;
  private boolean m_exitOnError;
  private String m_dbUrl ;
  private String m_dbUser ;
  private String m_dbPassword ;
  private String m_inputTypes ;
  private String m_inputObjects ;
  private String m_language ;
  private String m_format ;
  private boolean m_ignoreComments ;
  private boolean m_ignoreIdentifiers ;
  private boolean m_ignoreLiterals ;
  private Integer m_minimumTokens ;
  private boolean m_showSkippedPackages ;
  private boolean m_saveSourceCode ;
  private String  m_driverName ;
  private String  m_getMetadataStatement ;
  private Integer m_getMetadataStatementReturnType ;



  public PLDocCPDTask() {
    m_verbose = false;
    m_destdir = null;
    m_doctitle = null;
    m_outputFile = null;
    m_filesets = new ArrayList();
    m_stylesheet = null;
    m_sourcestylesheet = null;
    m_namesCase = 'D'; //Default to Oracle standard 
    m_inEnc = null;
    m_exitOnError = false;
    m_dbUrl = null;
    m_dbUser = null;
    m_dbPassword = null;
    m_inputTypes =  null;
    m_inputObjects =  null;
    m_showSkippedPackages = false;
    m_saveSourceCode = false;
    m_language = Settings.CPD_LANGUAGE_DEFAULT; 
    m_format = Settings.CPD_RENDER_FORMAT_DEFAULT; 
    m_minimumTokens = Settings.CPD_MINIMUM_TOKENS_DEFAULT;
    m_ignoreComments = false;
    m_ignoreIdentifiers = false;
    m_ignoreLiterals = false;
    m_driverName = null;
    m_getMetadataStatement = null;
    m_getMetadataStatementReturnType = null;
  }

 	public void setClasspath(Path classpath) {
		this.classpath = classpath;
	}

	public Path getClasspath() {
		return classpath;
	}

	public Path createClasspath() {
		if (classpath == null) {
			classpath = new Path(getProject());
		}
		return classpath.createPath();
	}

	public void setClasspathRef(Reference r) {
		createClasspath().setRefid(r);
	}

	public void setAuxClasspath(Path auxClasspath) {
		this.auxClasspath = auxClasspath;
	}

	public Path getAuxClasspath() {
		return auxClasspath;
	}

	public Path createAuxClasspath() {
		if (auxClasspath == null) {
			auxClasspath = new Path(getProject());
		}
		return auxClasspath.createPath();
	}

	public void setAuxClasspathRef(Reference r) {
		createAuxClasspath().setRefid(r);
	}
 
  
  public void setVerbose(boolean verbose) {
    m_verbose = verbose;
  }
  public void setDestdir(File dir) {
    m_destdir = dir;
  }
  public void setDoctitle(String doctitle) {
    m_doctitle = doctitle;
  }
  public void setOutputFile(File file) {
    m_outputFile = file;
  }
  public void addFileset(FileSet fset) {
    m_filesets.add(fset);
  }
  public void setStylesheet(File file) {
    m_stylesheet = file;
  }
  public void setSourceStylesheet(File file) {
    m_sourcestylesheet = file;
  }
  public void setInputEncoding(String enc) {
    m_inEnc = enc;
  }
  public void setExitOnError(boolean exitOnError) {
    m_exitOnError = exitOnError;
  }

  public void setDbUrl(String dbUrl) {
          this.m_dbUrl = dbUrl;
  }
  public void setDbUser(String dbUser) {
          this.m_dbUser = dbUser;
  }
  public void setDbPassword(String dbPassword) {
          this.m_dbPassword = dbPassword;
  }
  public void setInputObjects(String inputObjects) {
          this.m_inputObjects = inputObjects;
  }
  public void setInputTypes(String inputTypes) {
          this.m_inputTypes = inputTypes;
  }
  public void setShowSkippedPackages(boolean showSkippedPackages) {
    this.m_showSkippedPackages = showSkippedPackages;
  }
  public void setSaveSourceCode(boolean saveSourceCode) {
    this.m_saveSourceCode = saveSourceCode;
  }
  public void setLanguage(String language) {
    m_language = language;
  }
  public void setFormat(String format) {
    m_format = format;
  }
  public void setIgnoreComments(boolean ignoreComments) {
    this.m_ignoreComments = ignoreComments;
  }
  public void setIgnoreIdentifiers(boolean ignoreIdentifiers) {
    this.m_ignoreIdentifiers = ignoreIdentifiers;
  }
  public void setIgnoreLiterals(boolean ignoreLiterals) {
    this.m_ignoreLiterals = ignoreLiterals;
  }
  public void setMinimumTokens(Integer minimumTokens) {
          this.m_minimumTokens = minimumTokens;
  }
  public void setDriverName(String driverName) {
          this.m_driverName = driverName;
  }
  public void setGetMetadataStatement(String getMetadataStatement) {
          this.m_getMetadataStatement = getMetadataStatement;
  }
  public void setReturnType(Integer getMetadataStatementReturnType) {
          this.m_getMetadataStatementReturnType = getMetadataStatementReturnType;
  }



  public void execute()
      throws BuildException {
    // check args
    if (m_destdir == null)
      throw new BuildException("Property \"destdir\" (destination directory) MUST be specified");

    if (m_doctitle == null)
      m_doctitle = "PL/SQL";

    if (m_inEnc == null)
      m_inEnc = System.getProperty("file.encoding");

    // execute

    try {
      settings = new Settings();
      settings.setOutputDirectory(m_destdir);
      settings.setInputEncoding(m_inEnc);
      settings.setExitOnError(m_exitOnError);
      settings.setDbUrl(m_dbUrl);
      settings.setDbUser(m_dbUser);
      settings.setDbPassword(m_dbPassword);
      settings.setInputTypes( (null == m_inputTypes) 
                              ? new ArrayList() 
			      :  Arrays.asList(m_inputTypes.split(","))
			     );
      settings.setInputObjects( (null == m_inputObjects) 
                                ? new ArrayList() 
			       :  Arrays.asList(m_inputObjects.split(","))
			     );
      settings.setShowSkippedPackages(m_showSkippedPackages);
      settings.setSaveSourceCode(m_saveSourceCode);
      settings.setLanguage(m_language);
      settings.setFormat(m_format);
      settings.setIgnoreComments(m_ignoreComments);
      settings.setIgnoreIdentifiers(m_ignoreIdentifiers);
      settings.setIgnoreLiterals(m_ignoreLiterals);
      settings.setMinimumTileSize(m_minimumTokens);
      settings.setLanguage(m_language);
      settings.setFormat(m_format);
      settings.setOutputFile(m_outputFile);
      settings.setStylesheet(m_stylesheet);
      settings.setSourceStylesheet(m_sourcestylesheet);

      /* Set the non-Oracle settings only if defined, otherwise 
       * let the defaults apply  
       */
      if (null != m_driverName) settings.setDriverName(m_driverName);
      if (null != m_getMetadataStatement) settings.setGetMetadataStatement(m_getMetadataStatement);
      if (null != m_getMetadataStatementReturnType) settings.setReturnType(m_getMetadataStatementReturnType);


      Collection inputPaths = new ArrayList(); 
      // Add all the input files to a collection 
      for (int fsetI = 0; fsetI < m_filesets.size(); fsetI++) {
	FileSet fset = (FileSet) m_filesets.get(fsetI);
	DirectoryScanner dirScan = fset.getDirectoryScanner(getProject());
	File srcDir = fset.getDir(getProject());
	String[] srcFiles = dirScan.getIncludedFiles();
	for (int fileI = 0; fileI < srcFiles.length; fileI++) {
	  File inputFile = new File(srcDir, srcFiles[fileI]);
	   inputPaths.add(inputFile.getCanonicalPath());
	}
      }
      settings.setInputFiles(inputPaths);
      inputPaths = null;

      //Validate the settings 
      Collection inputFiles = settings.getInputFiles();
      Collection inputTypes = settings.getInputTypes();
      Collection inputObjects = settings.getInputObjects();

      // XOR the input file(s) OR object name(s) MUST be given
      if ((inputFiles.isEmpty() && inputObjects.isEmpty()) ||
	  (!inputFiles.isEmpty() && !inputObjects.isEmpty())) {
	throw new BuildException("You must specify input file name(s) or object name(s)!");
      }

      // When object name(s) are supplied, the connect info must be supplied.
      if (!inputObjects.isEmpty() &&
	  (settings.getDbUrl() == null || settings.getDbUser() == null || settings.getDbPassword() == null)) {
	throw new BuildException("Database url, db schema and db password are mandatory when object name(s) are supplied!");
      }

      // After specifying all relevant settings, just run the PLDoc process
      CPD cpd = new CPD(settings);

      // Start running
      try {
            //Collect all the Source
            cpd.run();

            //
            cpd.go();
            if (cpd.getMatches().hasNext()) {
                    //System.out.println(settings.renderer().render(cpd.getMatches()));
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
                    // && stylesheet.exists()
                    && "xml".equalsIgnoreCase(settings.getFormatString())
                    )
                {
                    System.err.println("Generating CPD HTML from " + outputFile.getAbsolutePath());
                    settings.generateHtml(outputFile);
                }
                
            }
      } catch (Exception e) {
	throw new BuildException(e);
      }

    } catch (java.io.IOException ioEx) {
      throw new BuildException(ioEx);
    } catch (Exception otherEx) {
      throw new BuildException(otherEx);
    }



    m_verbose = false;
    m_destdir = null;
    m_stylesheet = null;
    m_inEnc = null;
    m_dbUrl = null;
    m_dbUser = null;
    m_dbPassword = null;
    m_inputTypes = null;
    m_inputObjects = null;
    m_showSkippedPackages = false;
    m_saveSourceCode = false;
    m_ignoreComments = false;
    m_ignoreIdentifiers = false;
    m_ignoreLiterals = false;
    m_language = Settings.CPD_LANGUAGE_DEFAULT; 
    m_format = Settings.CPD_RENDER_FORMAT_DEFAULT; 
    m_minimumTokens = Settings.CPD_MINIMUM_TOKENS_DEFAULT;
    m_outputFile = null;
    m_stylesheet = null;
    m_sourcestylesheet = null;
  }
  
  private BufferedReader getInputReader(File file)
      throws java.io.IOException {
    return new BufferedReader(
        new InputStreamReader(CPDUtils.getBOMInputStream(new FileInputStream(file), m_inEnc) , m_inEnc) );
  }
  
    
    private void setupClassLoader() {

        if (classpath == null) {
                log("Using the normal ClassLoader", Project.MSG_VERBOSE);
        } else {
                log("Using the AntClassLoader", Project.MSG_VERBOSE);
                antClassLoader = new AntClassLoader(getProject(), classpath);
        }
    }
    
    
    
  
}
