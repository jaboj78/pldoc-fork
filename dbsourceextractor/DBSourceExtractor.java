/* Copyright (C) 2002 Albert Tumanov

$Id: DBSourceExtractor.java,v 1.1.1.1 2003/08/18 18:43:46 altumano Exp $

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

package org.dbsourceextractor;

import java.util.*;
import java.io.*;
import java.sql.*;

public class DBSourceExtractor
{

  private static boolean isDebugging;
  private static long t1, t2;
  private static final String NOT_WRITEABLE = " not writable.";
  private static final String OK = " ok.";
  private static final String NOT_FOUND_IN_DB = " not found in the database !";

  // command-line parameters
  private static String propertiesFileName;
  private static String user;
  private static String password;
  private static String connectString;
  private static String targetDir;

  static void debug(String message)
  {
    if (isDebugging)
      System.out.println(message);
  }

  /** Constructor */
  public DBSourceExtractor(String propertiesFileName, String user, String password, String connectString, String targetDir)
  {
    isDebugging = System.getProperty("debug", "false").equals("true");
    this.propertiesFileName = propertiesFileName;
    this.user = user;
    this.password = password;
    this.connectString = connectString;
    this.targetDir = targetDir;
  }

  /** Extracts source from database */
  public void extract() throws Exception
  {
    try {
      debug("Getting DBSource ");
      boolean onlyThisSchema = System.getProperty("only_this_schema", "true").equals("true");
      debug("onlyThisSchema = " + onlyThisSchema);
      DBSource db = new DBSource(user, password, connectString, onlyThisSchema);
      debug("Got DBSource, " + ((System.currentTimeMillis()-t1)) + " ms" );

      Collection obj_table = Files.readList(propertiesFileName);
      Iterator it = obj_table.iterator();
      while (it.hasNext())
      {
        DBObject obj = (DBObject) it.next();
        File file = new File(obj.filename());
        // if the filename is relative, prepend target directory
        if (!file.isAbsolute()) {
          file = new File(targetDir, obj.filename());
        }
        /*if (file.isAbsolute()) {
          throw new RuntimeException(file.toString());
        }*/
      
        // if the directory does not exist or is not writeable, skip the object
        if (!file.getParentFile().canWrite())
        {
          System.out.println(file.getParentFile() + NOT_WRITEABLE);
          continue;
        }
        // if the file exist, but not writeable, skip the object
        if (file.exists() && !file.canWrite())
        {
          System.out.println(file + NOT_WRITEABLE);
          continue;
        }

        // generate and store primary text
        if (obj.type1() != null && obj.type1().length() > 0)
        {
          StringBuffer txt1 = db.getLines(obj.type1(), obj.name());
          if (txt1 != null) {
            Files.stringToFile(txt1, file, false);
          } else {
            System.out.println();
            System.out.println(obj.name() + NOT_FOUND_IN_DB);
            System.out.println();
          }
        }

        // generate and append secondary text
        if (obj.type2() != null && obj.type2().length() > 0)
        {
          StringBuffer txt2 = db.getLines(obj.type2(), obj.name());
          if (txt2 != null) {
            Files.stringToFile(txt2, file, true);
          } else {
            System.out.println();
            System.out.println(obj.name() + NOT_FOUND_IN_DB);
            System.out.println();
          }
        }

        System.out.println(file + OK);
      }

    } catch (SQLException ex) {
      ex.printStackTrace();
      System.err.println ("\n*** SQLException details ***\n"); 
      while ( ex != null ) {
        System.err.println ("SQLState: " + ex.getSQLState ()); 
        System.err.println ("Message:  " + ex.getMessage ()); 
        System.err.println ("Error Code:   " + ex.getErrorCode ()); 
        ex = ex.getNextException (); 
      }
      System.exit(1);
    }
    
  }

  /** The main method */
  public static void main(String[] args) throws Exception
  {
    t1 = System.currentTimeMillis();
    debug("Started");
    if (args.length != 5)
    {
      System.out.println("Arguments: propfile user password connectstring targetdir");
      System.out.println("Names of database dictionary views maybe be specified, if different from defaults:");
      System.out.println("  -Dall_source=\"...\" -Dall_triggers=\"...\" -Dall_views=\"...\" ");
      System.out.println("If other schema's objects are extracted, specify (default is true):");
      System.out.println("  -Donly_this_schema=false ");
      System.out.println("To print debug info (default is false):");
      System.out.println("  -Ddebug=true ");
      return;
    }

    DBSourceExtractor dBSourceExtractor = new DBSourceExtractor(args[0], args[1], args[2], args[3], args[4]);
    dBSourceExtractor.extract();

    t2 = System.currentTimeMillis();
    System.out.println("\n" + ((t2-t1)/1000) + " sec" );
  }

}


