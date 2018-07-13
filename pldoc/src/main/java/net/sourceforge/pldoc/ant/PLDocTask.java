package net.sourceforge.pldoc.ant;

import org.apache.tools.ant.*;
import org.apache.tools.ant.types.*;

import java.io.*;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Properties;

import net.sourceforge.pldoc.*;

/**
 * PLDoc Ant Task
 * <p>To define task in project:</p>
 * <pre>
 *   &lt;taskdef
 *     name="pldoc"
 *     classname="net.sourceforge.pldoc.ant.PLDocTask"
 *     classpath="pldoc.jar" /&gt;
 * </pre>
 *
 * <p>To use:</p>
 * <pre>
 *   &lt;pldoc
 *     verbose = "yes" | "no" (default: "no")
 *     doctitle = text
 *     stylesheet = text
 *     sourcestylesheet = text
 *     destdir = dir-path
 *     overview = file-path
 *     namesCase = "upper" | "lower" | "mixed" | "default"  
 *     inputEncoding = encoding (default: OS dependant) &gt;
 *     ignoreInformalComments = (false | true) 
 *     showSkippedPackages = (false | true) 
 *     plscope = (false | true) 
 *     saveSourceCode = (false | true) 
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
 *  <dt>doctitle</dt><dd>Documentation title</dd>
 *  <dt>destdir</dt><dd>Directory to store documentation files (created if doesn't exist)</dd>
 *  <dt>overview</dt><dd>File with overview in HTML format</dd>
 *  <dt>stylesheet</dt><dd>Name of File containing CSS-stylesheet for the result documentation. If omitted, default CSS will be used.</dd>
 *  <dt>sourcestylesheet</dt><dd>Name of File containing CSS-stylesheet for any saved source code. If omitted, default CSS will be used.</dd>
 *  <dt>namesCase</dt><dd>Upper/Lower/Mixed/Default case to format PL/SQL names. If omitted, Oracle standard case conversion is done (unquoted to upper case, quoted left as mixed case).</dd>
 *  <dt>inputEncoding</dt><dd>Input files encoding</dd>
 *  <dt>ignoreInformalComments</dt><dd> true if documentation should be generated from formal comments only</dd>
 *  <dt>showSkippedPackages</dt><dd>Display list of packages which failed to parse</dd>
 *  <dt>plscope</dt><dd>Extract PLScope information and incorporate into PLDoc</dd>
 *  <dt>savesourcecode</dt><dd>SAve source code whilst reading it from the database and link to it within PLDocc</dd>
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
public class PLDocTask extends Task {
  private Settings settings;
  private boolean m_verbose;
  private File m_destdir;
  private String m_doctitle;
  private String m_stylesheet;
  private File m_overviewFile;
  private ArrayList m_filesets;
  private char m_namesCase;
  private String m_inEnc;
  private boolean m_exitOnError;
  private String m_dbUrl ;
  private String m_dbUser ;
  private String m_dbPassword ;
  private String m_inputTypes ;
  private String m_inputObjects ;
  private boolean m_ignoreInformalComments ;
  private boolean m_showSkippedPackages ;
  private boolean m_plscope ;
  private String  m_driverName ;
  private String  m_getMetadataStatement ;
  private Integer m_getMetadataStatementReturnType ;
  /** Should database source be saved to the file system whilst being read?
   */
  private boolean m_savesourcecode ;
  /** CSS Stylesheet to display the saved source code.
   */
  private String m_sourcestylesheet;



  public PLDocTask() {
    m_verbose = false;
    m_destdir = null;
    m_doctitle = null;
    m_stylesheet = null;
    m_overviewFile = null;
    m_filesets = new ArrayList();
    m_namesCase = 'D'; //Default to Oracle standard 
    m_inEnc = null;
    m_exitOnError = false;
    m_dbUrl = null;
    m_dbUser = null;
    m_dbPassword = null;
    m_inputTypes =  null;
    m_inputObjects =  null;
    m_showSkippedPackages = false;
    m_plscope = false;
    m_ignoreInformalComments = false;
    m_driverName = null;
    m_getMetadataStatement = null;
    m_getMetadataStatementReturnType = null;
    m_savesourcecode = false;
    m_sourcestylesheet = null;
  }

  public void setVerbose(boolean verbose) {
    this.m_verbose = verbose;
  }
  public void setDestdir(File dir) {
    this.m_destdir = dir;
  }
  public void setDoctitle(String doctitle) {
    this.m_doctitle = doctitle;
  }
  public void setStylesheet(String stylesheet) {
    this.m_stylesheet = stylesheet;
  }
  public void setSourceStylesheet(String sourcestylesheet) {
    this.m_sourcestylesheet = sourcestylesheet;
  }
  public void setOverview(File file) {
    this.m_overviewFile = file;
  }
  public void addFileset(FileSet fset) {
    this.m_filesets.add(fset);
  }
  public void setInputEncoding(String enc) {
    this.m_inEnc = enc;
  }
  public void setExitOnError(boolean exitOnError) {
    this.m_exitOnError = exitOnError;
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
  public void setPlscope(boolean plscope) {
    this.m_plscope = plscope;
  }
  public void setSaveSourceCode(boolean savesourcecode) {
    this.m_savesourcecode = savesourcecode;
  }
  public void setIgnoreInformalComments(boolean ignoreInformalComments) {
    this.m_ignoreInformalComments = ignoreInformalComments;
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


  public static class NamesCase extends EnumeratedAttribute {
    public String[] getValues() {
      return new String[] {"upper", "lower","mixed","default"};
    }
  }

  public void setNamesCase(NamesCase namesCase) {
    m_namesCase = Character.toUpperCase(namesCase.getValue().charAt(0));
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
      settings.setApplicationName(m_doctitle);
      if (null != m_stylesheet) settings.setStylesheetfile(m_stylesheet);
      if (null != m_sourcestylesheet) settings.setSourceStylesheetfile(m_sourcestylesheet);
      if (null != m_overviewFile) settings.setOverviewfile(m_overviewFile);
      switch (m_namesCase) {
        case 'U':
          settings.setDefaultNamescase("upper");
          settings.setNamesLowercase(false);
          settings.setNamesUppercase(true);
          settings.setNamesDefaultcase(true);
          break;
        case 'L':
          settings.setDefaultNamescase("lower");
          settings.setNamesLowercase(true);
          settings.setNamesUppercase(false);
          settings.setNamesDefaultcase(true);
          break;
        case 'M': // Leave names case entirely untouched 
          settings.setDefaultNamescase("mixed");
          settings.setNamesLowercase(false);
          settings.setNamesUppercase(false);
          settings.setNamesDefaultcase(true);
          break;
        case 'D': // Leave settings as per PLDoc/Oracle defaults 
          settings.setDefaultNamescase("upper");
          settings.setNamesLowercase(false);
          settings.setNamesUppercase(false);
          settings.setNamesDefaultcase(true);
          break;
      }
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
      settings.setPlscope(m_plscope);
      settings.setSaveSourceCode(m_savesourcecode);
      settings.setIgnoreInformalComments(m_ignoreInformalComments);

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
      PLDoc pldoc = new PLDoc(settings);

      // Start running
      try {
	pldoc.run();
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
    m_doctitle = null;
    m_overviewFile = null;
    m_stylesheet = null;
    m_sourcestylesheet = null;
    m_namesCase = '0';
    m_inEnc = null;
    m_dbUrl = null;
    m_dbUser = null;
    m_dbPassword = null;
    m_inputTypes = null;
    m_inputObjects = null;
    m_showSkippedPackages = false;
    m_plscope = false;
    m_savesourcecode = false;
    m_ignoreInformalComments = false;
  }
  
  private BufferedReader getInputReader(File file)
      throws java.io.IOException {
    return new BufferedReader(
        new InputStreamReader(Utils.getBOMInputStream(new FileInputStream(file), m_inEnc)
		              , m_inEnc)
	                     );
  }
}
