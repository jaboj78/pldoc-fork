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

import org.apache.commons.io.input.BOMInputStream;
import org.apache.commons.io.ByteOrderMark;

/**
* Utilities supporting the main functionality
* @author Albert Tumanov
* @version $Header: /cvsroot/pldoc/sources/src/java/net/sourceforge/pldoc/Utils.java,v 1.3 2004/04/18 18:27:23 altumano Exp $
*/
public class Utils
{

  /** Copy a file with a fall back resource.
  * @param inputFile source 
  * @param outputFile target 
  * @param resourceName - internal resource to use if inputFile does not exist
  * @throws FileNotFoundException if the file does not exist  
  * @throws IOException on input error
  */
  public static void CopyFile(File inputFile, File outputFile, String resourceName )
  throws FileNotFoundException, IOException
  {
    try {
      // Copy inputFile if it exists, falling back to the resource if it does not
      Utils.CopyStreamToFile(
        (null != inputFile && inputFile.exists()) 
          ?  Utils.getBOMInputStream(new FileInputStream(inputFile),null) 
          : (new ResourceLoader()).getResourceStream(resourceName)
        , outputFile
      );

    } 
    catch(IOException e) {
      throw new IOException ( String.format("Problem copying File \"%s\" with fallback resource \"%s\" to \"%s\"", inputFile, resourceName, outputFile )
                            , e
                          );
    }
  }

  /** Copies a file.
  * I wish there was a standard Java way to do it.
  * @param inputFile source 
  * @param outputFile target 
  * @throws FileNotFoundException if the file does not exist  
  * @throws IOException on input error
  */
  public static void CopyFile(File inputFile, File outputFile)
  throws FileNotFoundException, IOException
  {
    FileReader in = new FileReader(inputFile);
    FileWriter out = new FileWriter(outputFile);
    int c;

    while ((c = in.read()) != -1) {
       out.write(c);
    }

    in.close();
    out.close();
  }

  /** Copies a InputStream into a file.
  * I wish there was a standard Java way to do it.
  * @param inputStream source 
  * @param outputFile target 
  * @throws FileNotFoundException if the file does not exist  
  * @throws IOException on input error
  */
  public static void CopyStreamToFile(InputStream inputStream, File outputFile)
  throws FileNotFoundException, IOException
  {
    InputStreamReader in = new InputStreamReader(inputStream);
    FileWriter out = new FileWriter(outputFile);
    int c;

    while ((c = in.read()) != -1) {
       out.write(c);
    }

    in.close();
    out.close();
  }


  /** Copies a Reader into a file.
  * @param reader source 
  * @param outputFile target 
  * @throws FileNotFoundException if the file does not exist  
  * @throws IOException on input error
  */
  public static void CopyReaderToFile(Reader reader, File outputFile)
  throws FileNotFoundException, IOException
  {
    FileWriter out = new FileWriter(outputFile);
    int c;

    while ((c = reader.read()) != -1) {
       out.write(c);
    }

    reader.close();
    out.close();
  }

  /** Aggregate contents of an InputStream into a String 
  * @param inputStream source 
  * @return aggregated contents
  * @throws IOException on input error
  */
  public static String getStringFromInputStream(InputStream inputStream) throws IOException  
   {
	byte[] inputBuffer = new byte[1024];
	StringBuffer stringBuffer = new StringBuffer(1024);

	    int bytesRead;
	    while (inputStream.available() > 0) {
		bytesRead = inputStream.read(inputBuffer);
		stringBuffer.append(new String(inputBuffer, 0, bytesRead));
	    }
        return stringBuffer.toString(); 
  }

 /**
  * Copies required static files into the source code directory.
  *
  * This allows the XSL and CSS hrefs to cope with relocation of the root output directory 
  * or access through a web browser.
  *
  * @param outputDirectory directory to copy files
  * @param relativePath the relative path to the location of the root output directory 
  * @throws Exception on read or write error
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
  * Copy required static files into the root output directory.
  *
  * @param outputDirectory directory to copy files
  * @param stylesheet explicit PLDoc CSS stylesheet 
  * @param sourceStylesheet explicit scraped source code CSS stylesheet 
  * @throws Exception on read or write error
  */
  public static void copyStaticRootDirectoryFiles(File outputDirectory, File stylesheet, File sourceStylesheet) throws Exception {
      CopyFile(stylesheet
              ,new File(outputDirectory, "stylesheet.css")
              ,"defaultstylesheet.css"
      );

      CopyFile(sourceStylesheet
            	,new File(outputDirectory, "sourcestylesheet.css")
              ,"defaultstylesheet.css"
      );
  }

  

  /**
  * Return an InputStream, stripping out any BOM if the specified or default character encoding is UTF*.
  *
  * @param inputStream Stream that may or may not contain a BOM
  * @param inputEncoding file encoding 
  * @throws IOException on input error
  *
  * @return InputStream with any BOM stripped.
  */
  public static InputStream getBOMInputStream(InputStream inputStream, String inputEncoding) throws IOException {
      if( (null == inputEncoding && System.getProperty("file.encoding").startsWith("UTF"))
          || inputEncoding.startsWith("UTF")
         )    
      {
        return new BOMInputStream(inputStream
                                  ,ByteOrderMark.UTF_8
                                  ,ByteOrderMark.UTF_16LE
                                  ,ByteOrderMark.UTF_16BE
                                  ,ByteOrderMark.UTF_32LE
                                  ,ByteOrderMark.UTF_32BE
        );
      }
      else 
      {
        return inputStream;
      }
  }

  
}
