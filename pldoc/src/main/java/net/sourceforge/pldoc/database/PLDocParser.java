package net.sourceforge.pldoc.database;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Clob;

import java.io.*;
import java.sql.*;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Properties;
import javax.xml.transform.URIResolver;

import net.sourceforge.pldoc.*;

/** 
 * Provide a database API for PLDoc, allowing code to be documented within the database. 
 */
public class PLDocParser {

  public PLDocParser() {
    this.settings =  new Settings(); 
  }

  public PLDocParser(Settings settings) {
    this.settings =  settings; 
  }

  private Settings settings = new Settings(); //Initially use default settings 

  public Settings getSettings() {
    return settings; 
  }

  public void setSettings(Settings settings) {
    this.settings =  settings; 
  }

  /**
  * Parse object PLDoc into intermediate XML.
  *
  * @param schemaName   The name of the owner of the object to be parsed
  * @param objectName   The name of the object to be parsed
  * @param objectType   The type of the object to be parsed
  * @param objectCode   Object code to parsed
  * @param parsedCode   Clob that parsed information will be written to 
  * @throws Exception   Thrown if an error occurred and the user specified the halt on errors option.
  *                               All other throwables will be caught.
  */

  public void parse(String schemaName, String objectName, String objectType, Clob objectCode, Clob parsedCode)
      throws Exception {

      // After specifying all relevant settings, just run the PLDoc process
      PLDoc pldoc = new PLDoc(settings);

      // XMLriter takes Outputstream, not Writer 
      XMLWriter xmlWriter = new XMLWriter(parsedCode.setAsciiStream(0));
      xmlWriter.startDocument();
      

      //Parse this object 
      Throwable throwable = pldoc.processPackage(
                                                new BufferedReader(objectCode.getCharacterStream())
                                              ,xmlWriter 
                                              ,objectName
                                              ,schemaName
                                              ,"PUBLIC"
                                            );
      xmlWriter.endDocument();

      if (null != throwable) {
        throw new Exception( "Could not parse code for " 
                                        + objectType + ": " 
                                        + schemaName + "." + objectName  
                            ,throwable
                            );
      }
  }  

  
  /**
  * Parse object PLDoc into intermediate XML.
  *
  * @param schemaName   The name of the owner of the object to be parsed
  * @param objectName   The name of the object to be parsed
  * @param objectType   The type of the object to be parsed
  * @param objectCode   Object code to parsed
  * @param parsedCode   SQLXML that parsed information will be written to 
  * @throws Exception   Thrown if an error occurred and the user specified the halt on errors option.
  *                               All other throwables will be caught.
  */

  /*
  public static void parse(String schemaName, String objectName, String objectType, Clob objectCode, SQLXML  parsedCode)
      throws Exception {

      Settings settings = new Settings(); //Use default settings 
      // After specifying all relevant settings, just run the PLDoc process
      PLDoc pldoc = new PLDoc(settings);

      // XMLriter takes Outputstream, not Writer 
      XMLWriter xmlWriter = new XMLWriter(parsedCode.setBinaryStream());
      xmlWriter.startDocument();
      

      //Parse this object 
      Throwable throwable = pldoc.processPackage(
                                                new BufferedReader(objectCode.getCharacterStream())
                                              ,xmlWriter 
                                              ,objectName
                                              ,schemaName
                                              ,"PUBLIC"
                                            );
      xmlWriter.endDocument();

      if (null != throwable) {
        throw new Exception( "Could not parse code for " 
                                        + objectType + ": " 
                                        + schemaName + "." + objectName  
                            ,throwable
                            );
      }
  }  
  */

  /**
  * Helper method to return fixed URIResolver to alternative applications: this provides read access to internal PLDoc resources such as stylesheets.
  *
  * @return URIResolver including internal PLDoc resources.
  */
  public static URIResolver getResourceResolver() {
      return PLDoc.getResourceResolver();
  }


  /**
  * Helper method to return InputStream from internal PLDoc resources such as stylesheets.
  *
  * @param path name of internal resopurce 
  * @return internal PLDoc resources.
  * @throws IOException on problem retrieving PLDoc resource. 
  */
   public static InputStream getResourceStream(String path) throws java.io.IOException {
    
      return PLDoc.getResourceStream(path);
  }

  /**
  * Helper method to copy PLDoc resource to provided Clob 
  *
  * @param path name of internal resopurce 
  * @param resourceClob target database Clob.
  * @throws IOException on problem retrieving PLDoc resource or copying to output. 
  * @throws SQLException on problem retrieving PLDoc resource. 
  */
   public static void setResource(String path, Clob resourceClob) throws java.io.IOException, java.sql.SQLException {

      Writer output = resourceClob.setCharacterStream(1);
      PLDocParser.copy ( PLDoc.getResourceStream(path) , output ) ;

  }

  /**
  * Helper method to provision and return Clob from PLDoc resource 
  *
  * @param path name of internal resopurce 
  * @param resourceClob target database Clob.
  * @throws IOException on problem retrieving PLDoc resource or copying to output. 
  * @throws SQLException on problem retrieving PLDoc resource. 
  * @return provisioned database object.
  */
   public static Clob getResource(String path, Clob resourceClob) throws java.io.IOException, java.sql.SQLException {
    
      PLDocParser.setResource (path, resourceClob ) ;
      return resourceClob; 
  }

 
 /** 
  * Perform <i>ad hoc</i> test using command line parameters or defaults if not supplied.
  * @param args array of command-line parameters 
  * @throws Exception on any encountered error  
  */
  public static void main(String[] args) throws Exception
  {
    String          dbURL               = "jdbc:oracle:thin:@192.168.100.22:1521:orcl";
    String          dbUser              = "SYSTEM";
    String          dbPassword          = "oracle";
    Connection      conn                = null;
    String          schemaName          = "PLDOC";
    String          objectName          = "TIMESTAMP_TEST";
    String          objectType          = "PACKAGE_SPEC";

    java.sql.Clob objectCode = null;
    java.sql.Clob parsedCode = null;
    //java.sql.SQLXML parsedXML = null;
    
    String generateOutputXML = "BEGIN ? := new XMLType('<dummy></dummy>');  END;" ;
    String generateOutputCLOB = "BEGIN DBMS_LOB.createTemporary(?,TRUE) ; END;" ;
    String generateInputCLOB = "BEGIN :1 := 'create or replace"
                                  +"\npackage       timestamp_test is"
                                  +"\n"
                                  +"\nTYPE VARYING_ARRAY IS VARYING ARRAY(10) OF INTEGER;"
                                  +"\nTYPE REF_CURSOR IS REF CURSOR;"
                                  +"\n"
                                  +"\nprocedure some_procedure("
                                  +"\ntime_var timestamp with time zone,"
                                  +"\n  long_raw_var long raw,"
                                  +"\n  varying_array_var VARYING_ARRAY,"
                                  +"\ndouble_prec_var DOUBLE PRECISION,"
                                  +"\n  int_day_2_second_var INTERVAL DAY TO SECOND,"
                                  +"\n  int_y_2_m_var INTERVAL YEAR TO MONTH,"
                                  +"\n  time_local_var TIMESTAMP WITH LOCAL TIME ZONE,"
                                  +"\n  ref_cursor_var REF_CURSOR"
                                  +"\n);"
                                  +"\n"
                                  +"\nend;' ; END;" ;

    String inputCLOB = "create or replace"
                                  +"\npackage       timestamp_test is"
                                  +"\n"
                                  +"\nTYPE VARYING_ARRAY IS VARYING ARRAY(10) OF INTEGER;"
                                  +"\nTYPE REF_CURSOR IS REF CURSOR;"
                                  +"\n"
                                  +"\nprocedure some_procedure("
                                  +"\ntime_var timestamp with time zone,"
                                  +"\n  long_raw_var long raw,"
                                  +"\n  varying_array_var VARYING_ARRAY,"
                                  +"\ndouble_prec_var DOUBLE PRECISION,"
                                  +"\n  int_day_2_second_var INTERVAL DAY TO SECOND,"
                                  +"\n  int_y_2_m_var INTERVAL YEAR TO MONTH,"
                                  +"\n  time_local_var TIMESTAMP WITH LOCAL TIME ZONE,"
                                  +"\n  ref_cursor_var REF_CURSOR"
                                  +"\n);"
                                  +"\n"
                                  +"\nend;" ;

    long startTime = System.currentTimeMillis();
    System.out.println("");
    System.out.println("TEST");
    

    // process arguments
    Settings settings = new Settings();
    settings.processCommandString(args);
    PLDocParser parser = new PLDocParser(settings);
    
    //settings.setDbUrl(dbURL);
    //settings.setDbUser(dbUser);
    //settings.setDbPassword(dbPassword);

    Class.forName(settings.getDriverName());
    //Internal conn = DriverManager.getConnection("jdbc:oracle:kprb:");
    conn = DriverManager.getConnection( settings.getDbUrl(), settings.getDbUser(), settings.getDbPassword() );

    objectCode = conn.createClob(); // (java.sql.Clob) getDBObject(conn,java.sql.Types.CLOB,generateInputCLOB);
    int added = objectCode.setString(1, inputCLOB); //Write inputCLOB into the string 
    System.out.println("Added (" + added + " chracters to the Input ClOB seconds).");

    parsedCode = conn.createClob(); // (java.sql.Clob) getDBObject(conn,java.sql.Types.CLOB, generateOutputCLOB);
    // start running
    
    // start running
    try {
      parser.parse(schemaName, objectName, objectType, objectCode, parsedCode);
    } catch (Exception e) {
      e.printStackTrace(System.err);
      System.exit(-1);
    }

    long finishTime = System.currentTimeMillis();
    System.out.println("Done (" + (finishTime-startTime)/1000.00 + " seconds).");

    

    System.out.println("INPUTCLOB :");
    int copied = copy( objectCode.getCharacterStream(), System.out) ;
    System.out.println("\n");
    System.out.println("Copied "+ copied + " characters" );

    System.out.println("PARSEDCLOB ");
    copied = copy( parsedCode.getCharacterStream(), System.out) ;
    System.out.println("\n");
    System.out.println("Copied "+ copied + " characters" );


   // Try with SQLXML
   //System.out.println("PARSEDXML ");
   //parsedXML = (java.sql.SQLXML) getDBObject(conn,java.sql.Types.SQLXML, generateOutputXML);
   //Writer parsedXMLWriter = parsedXML.setCharacterStream() ;    //(java.sql.SQLCLOB) getDBObject(conn,java.sql.Types.CLOB, generateOutputCLOB);
   
    //copied = copy( parsedCode.getCharacterStream(), parsedXMLWriter ) ;
    //System.out.println("\n");
    //System.out.println("Copied "+ copied + " characters" );


    
    
    objectCode.free();
    parsedCode.free();
    //parsedXML.free();
    
  }
  
 public static int copy(InputStream input, OutputStream output) throws IOException
 {
      
    byte[] buffer= new byte[100];
    int totalWritten = 0;
    int n = 0 ; // number of characters read
    while (-1 != (n = input.read(buffer)))
    {
      output.write(buffer,0,n);
      totalWritten += n ;
    }      
    output.flush();
    //out.close();
    //input.close();
    
    return totalWritten;
  }

 public static int copy(Reader input, OutputStream output) throws IOException
 {
      
    char[] buffer= new char[100];
    int totalWritten = 0;
    int n = 0 ; // number of characters read
    OutputStreamWriter out = new OutputStreamWriter(output);
    while (-1 != (n = input.read(buffer)))
    {
      out.write(buffer,0,n);
      totalWritten += n ;
    }      
    out.flush();
    //out.close();
    //input.close();
    
    return totalWritten;
  }
  
 public static int copy(InputStream input, Writer output) throws IOException
 {
      
    char[] buffer= new char[100];
    int totalWritten = 0;
    int n = 0 ; // number of characters read
    InputStreamReader in = new InputStreamReader(input);
    while (-1 != (n = in.read(buffer)))
    {
      output.write(buffer,0,n);
      totalWritten += n ;
    }      
    output.flush();
    //output.close();
    //input.close();
    
    return totalWritten;
  }


  
 public static int copy(Reader input, Writer output) throws IOException
 {
      
    char[] buffer= new char[100];
    int totalWritten = 0;
    int n = 0 ; // number of characters read
    while (-1 != (n = input.read(buffer)))
    {
      output.write(buffer,0,n);
      totalWritten += n ;
    }      
    output.flush();
    //output.close();
    //input.close();
    
    return totalWritten;
  }


 /**
   * Helper method to confirm database working. 
   * @param connection Database connection 
   * @param returnType the required/expected return type java.sql.Types}  
   * @param sqlStatement the SQl steatement to generate the daatabase object
   * @return  the databse Object to be returned 
   * @throws SQLException on database connection or access problems  
   */
   public static Object getDBObject (
      Connection connection
      , int returnType
      ,String sqlStatement
      )
  throws SQLException
  {
    CallableStatement adHocStatement = null;
    Object result;

    adHocStatement  = connection.prepareCall(sqlStatement);
    adHocStatement.registerOutParameter(1, returnType);

    // execute statement
    adHocStatement.executeUpdate();
    // retrieve OUT parameter
    result = adHocStatement.getObject(1);

    return result ;
  }
}
