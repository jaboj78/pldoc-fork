package net.sourceforge.pldoc;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.Clob;

public class DbmsMetadata
{

  /* connection management */
  protected Connection conn = null;
  protected String  getMetadataStatement = null ;
  protected CallableStatement callableStatement = null;
  protected int  returnType = java.sql.Types.CLOB ;
  public Connection getConnection() throws SQLException
  { return conn; }

  /* constructors */
  public DbmsMetadata(Connection c) throws SQLException
  { conn = c; }

  public DbmsMetadata(Connection c, String getMetadataStatement, int returnType) throws SQLException
  { conn = c; 
	  this.getMetadataStatement = getMetadataStatement ; 
	  this.returnType =  returnType;
	  // Define this statement once, then call with different parameters
	    callableStatement  = getConnection().prepareCall(getMetadataStatement);
	    callableStatement.registerOutParameter(1, returnType);
  } 


  public java.io.Reader getDdl (
    String objectType,
    String name,
    String schema,
    String version,
    String model,
    String transform)
  throws SQLException
  {
    Object result;

//  ************************************************************
//  #sql [getConnectionContext()] result = { VALUES(DBMS_METADATA.GET_DDL(
//        :objectType,
//        :name,
//        :schema,
//        :version,
//        :model,
//        :transform))  };
//  ************************************************************

    // declare temps
    //CallableStatement st = null;
    //String theSqlTS = getMetadataStatement ;

    /*
    System.err.println( "(objectType, name, schema, version, model, transform) = ("+
                objectType + "," + name + "," + schema + "," + version + "," +
                model + "," + transform + ")" );
    */

    /* Only define callableStatement once and reuse it for subsequent calls to getDDL()*/ 
    if (null == callableStatement)
    {
	    callableStatement  = getConnection().prepareCall(getMetadataStatement);
	    callableStatement.registerOutParameter(1, returnType);
    }

    // set IN parameters
    callableStatement.setString(2, objectType);
    callableStatement.setString(3, name);
    callableStatement.setString(4, schema);
    callableStatement.setString(5, version);
    callableStatement.setString(6, model);
    callableStatement.setString(7, transform);
    // execute statement
    callableStatement.executeUpdate();
    // retrieve OUT parameters
    result = callableStatement.getObject(1);

    /*
	    System.err.println("returnType is " + returnType); 
    if (java.sql.Types.CLOB == returnType) 
    {
       System.err.println("return string is \"" + result +"\""); 
       System.err.println("return.toString() is \"<<<" + result.toString() +"\">>>"); 
    }
    */
    return (java.sql.Types.CLOB == returnType) 
	    ? ((Clob) result).getCharacterStream()
	    //: new java.io.StringReader((String) result)
	    : new java.io.StringReader( result.toString() )
	    ;
  }
}
