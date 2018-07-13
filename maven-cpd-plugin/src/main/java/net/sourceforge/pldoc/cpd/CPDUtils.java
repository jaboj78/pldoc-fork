package net.sourceforge.pldoc.cpd;

import java.io.*;
import java.util.Properties;
import net.sourceforge.pldoc.Utils;
// Use local version import net.sourceforge.pldoc.ResourceLoader;
import net.sourceforge.pldoc.SubstitutionReader;

/**
* Utilities supporting the main functionality
* @author Stuart Turton 
*/
public class CPDUtils 
{


  /**
  * Copy required static files into the source code directory.
  *
  *<p>This allows the XSL and CSS hrefs to cope with relocation of the root output directory 
  * or access through a web browser.
  *</p>
  *
  * @param outputDirectory directory to copy files
  * @param relativePath the relative path to the location of the root output directory 
  * @throws Exception on error 
  */
  public static void copyStaticSourceDirectoryFiles(File outputDirectory, String relativePath) throws Exception {
    try {
      // Copy sourcecode.xsl, replacing the stylesheet href with the relative href
      Properties  replacementProperties = new Properties();
      replacementProperties.put("sourcestylesheet.css", relativePath + "sourcestylesheet.css");
      Utils.CopyReaderToFile(
	new BufferedReader(
	  new SubstitutionReader( 
	    new BufferedReader(
	      new InputStreamReader(
				    (new ResourceLoader()).getResourceStream("sourcecode.xsl")
				   )
		)
	       ,replacementProperties
	      )
	    )
      , new File(outputDirectory.getPath() + File.separator + "sourcecode.xsl")
      );
    } catch(FileNotFoundException e) {
      System.err.println("File not found. ");
      e.printStackTrace();
      throw e;
    }
  }

  /**
  * Copies required static files into the root output directory.
  *
  * @param outputDirectory directory to copy files
  * @param stylesheet general CSS Stylesheet to format HTML pages   
  * @param sourceStylesheet general CSS Stylesheet to format source code HTML pages   
  * @throws Exception on error 
  */
  public static void copyStaticRootDirectoryFiles(File outputDirectory, File stylesheet, File sourceStylesheet) throws Exception {
    try {
      // Copy sourcecode.xsl, replacing the stylesheet href with the relative href
      Utils.CopyStreamToFile(
	  (null != stylesheet && stylesheet.exists()) 
	  ? Utils.getBOMInputStream(new FileInputStream ( stylesheet ) , null )
	  : (new ResourceLoader()).getResourceStream("defaultstylesheet.css")
	, new File(outputDirectory, "stylesheet.css")
      );

      Utils.CopyStreamToFile(
	  (null != sourceStylesheet && sourceStylesheet.exists()) 
	  ? Utils.getBOMInputStream(new FileInputStream ( sourceStylesheet ) , null )
	  : (new ResourceLoader()).getResourceStream("defaultstylesheet.css")
	, new File(outputDirectory, "sourcestylesheet.css")
      );
    } catch(FileNotFoundException e) {
      System.err.println("File not found. ");
      e.printStackTrace();
      throw e;
    }
  }

 

  /**
  * Return an InputStream, stripping out any BOM if the specified or default chracter encoding is UTF*.
  *
  * @param inputStream Stream that may or may not contain a BOM
  * @param inputEncoding file encoding of code in this InputStream 
  * @return InputSTream with any BOM stripped.
  * @throws IOException on read error 
  */
  public static InputStream getBOMInputStream(InputStream inputStream, String inputEncoding) throws IOException {

      return Utils.getBOMInputStream(inputStream, inputEncoding) ;
  }


}
