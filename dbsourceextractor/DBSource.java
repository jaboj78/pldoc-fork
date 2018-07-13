/* Copyright (C) 2002 Albert Tumanov

$Id: DBSource.java,v 1.1.1.1 2003/08/18 18:43:46 altumano Exp $

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

import java.io.*;
import java.sql.*;
import java.util.*;
//import oracle.jdbc.driver.OracleLog;

public final class DBSource
{
  private static final int ROWS_PREFETCH = 1000;
  
  private static final String PACKAGE = "PACKAGE";
  private static final String PACKAGE_BODY = "PACKAGE BODY";
  private static final String PROCEDURE = "PROCEDURE";
  private static final String FUNCTION = "FUNCTION";
  private static final String TABLE = "TABLE";
  private static final String INDEX = "INDEX";
  private static final String SYNONYM = "SYNONYM";
  private static final String SEQUENCE = "SEQUENCE";
  private static final String VIEW = "VIEW";
  private static final String TRIGGER = "TRIGGER";
  private static final String CREATE_TABLE = "CREATE TABLE ";
  private static final String CREATE_OR_REPLACE_VIEW = "CREATE OR REPLACE VIEW ";
  private static final String AS = " AS";
  private static final String CREATE_OR_REPLACE_TRIGGER = "CREATE OR REPLACE TRIGGER ";
  private static final String CREATE_OR_REPLACE = "CREATE OR REPLACE";

  private String schema;
  private Connection conn;
  private PreparedStatement stmtTables;
  private PreparedStatement stmtConstraints;
  private PreparedStatement stmtConsColumns;
  private PreparedStatement stmtTabComments;
  private PreparedStatement stmtColComments;
  private PreparedStatement stmtGrants;
  private PreparedStatement stmtSynonyms;
  private PreparedStatement stmtSequences;
  private PreparedStatement stmtIndexes;
  private PreparedStatement stmtIndexColumns;
  private PreparedStatement stmtViews;
  private PreparedStatement stmtTriggers;
  private PreparedStatement stmtSource;

  public DBSource(String username, String password, String connectString, boolean onlyThisSchema) throws SQLException
  {
    this.schema = username.toUpperCase();
    String scope;
    if (onlyThisSchema) {
      scope = "user";
    } else {
      scope = "all";
    }
    DBSourceExtractor.debug(scope);

    //if (System.getProperty("JdbcTrace", "false").equals("true")) {
    //  System.out.println("JdbcTrace seen to be true - enabling trace");
    //  OracleLog.setLogStream(System.out);
    //} 

    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    conn = DriverManager.getConnection(connectString, username, password);        
    if (conn==null)
      throw new NullPointerException("DriverManager returned null connection");

    //java.io.PrintWriter w =
    //  new java.io.PrintWriter
    //    (new java.io.OutputStreamWriter(System.out));
    //DriverManager.setLogWriter(w);

    if (System.getProperty("JdbcTrace", "false").equals("true")) {
      System.out.println("JdbcTrace seen to be true - enabling trace");
      DriverManager.setLogStream(System.out);
    } 

    conn.setAutoCommit(false);
    //((OracleConnection)conn).setDefaultRowPrefetch(ROWS_PREFETCH);

    // read view names from command line properties or use defaults
    String tableColumns = System.getProperty("all_tab_columns", scope + "_tab_columns");
    String tableConstraints = System.getProperty("all_constraints", scope + "_constraints");
    String tableConsColumns = System.getProperty("all_cons_columns", "all_cons_columns"); // must use "all" to resolve foreign keys
    String tableComments = System.getProperty("all_tab_comments", scope + "_tab_comments");
    String tableColComments = System.getProperty("all_col_comments", scope + "_col_comments");
    String grants = System.getProperty("all_tab_privs_made", scope + "_tab_privs_made");
    String synonyms = System.getProperty("all_synonyms", scope + "_synonyms");
    String sequences = System.getProperty("all_sequences", scope + "_sequences");
    String indexes = System.getProperty("all_indexes", scope + "_indexes");
    String indexColumns = System.getProperty("all_ind_columns", scope + "_ind_columns");
    String views = System.getProperty("all_views", scope + "_views");
    String triggers = System.getProperty("all_triggers", scope + "_triggers");
    String source = System.getProperty("all_source", scope + "_source");

    // prepare statements
    stmtTables = conn.prepareStatement(
      "select " + 
      ((onlyThisSchema)? ("'" + schema + "'" + " owner"):"owner") +  // user_tab_columns does not have OWNER column, that is the problem
      ", table_name, column_name, data_type, data_length, data_precision, data_scale, nullable " + 
      "from " + tableColumns + " where table_name = ? order by column_id");
    stmtConstraints = conn.prepareStatement(
      "select owner, constraint_name, table_name, r_owner, r_constraint_name, " +
      "  decode(constraint_type, 'P','PRIMARY KEY', 'U','UNIQUE', 'C','CHECK', 'R','FOREIGN KEY', constraint_type) type_name, " +
      "  decode(delete_rule, 'NO ACTION','', 'CASCADE','ON DELETE CASCADE', '') on_delete, " +
      "  search_condition " + // JDBC driver likes it to be the last 
      "from " + tableConstraints + " where table_name = ? " + 
      "order by decode(constraint_type, 'P',1, 'U',2, 'C',4, 'R',3, 10), " +
      "  constraint_name");
    stmtConsColumns = conn.prepareStatement(
      "select owner, constraint_name, table_name, column_name, position " +
      "from " + tableConsColumns + " where owner = ? and constraint_name = ? " + 
      "order by position");
    stmtTabComments = conn.prepareStatement(
      "select table_name, table_type, comments " +
      "from " + tableComments + " where table_name = ? ");
    stmtColComments = conn.prepareStatement(
      "select table_name, column_name, comments " +
      "from " + tableColComments + " where table_name = ? " +
      "order by column_name");
    stmtGrants = conn.prepareStatement(
      "select privilege, grantor, table_name, grantee, grantable " +
      "from " + grants + " where table_name = ? " +
      "order by table_name, grantee, privilege");
    stmtIndexes = conn.prepareStatement(
      "select index_name, index_type,table_owner, table_name, table_type, uniqueness " +
      "from " + indexes + " where index_name = ? ");
    stmtIndexColumns = conn.prepareStatement(
      "select * " + // selecting all, because 8i and 8 columns vary
      "from " + indexColumns + " where index_name = ? " + 
      "order by column_position");
    stmtSynonyms = conn.prepareStatement(
      "select synonym_name, table_owner, table_name, db_link " +
      "from " + synonyms + " where synonym_name = ? ");
    stmtSequences = conn.prepareStatement(
      "select sequence_name, min_value, max_value, increment_by, cycle_flag, " +
      "  order_flag, cache_size, last_number " +
      "from " + sequences + " where sequence_name = ? ");
    stmtViews = conn.prepareStatement(
      "select view_name, text from " + views + " where view_name = ?");
    stmtViews.setFetchSize(ROWS_PREFETCH);
    stmtTriggers = conn.prepareStatement(
      "select trigger_name, description, trigger_body from " + triggers + " where trigger_name = ?");
    stmtTriggers.setFetchSize(ROWS_PREFETCH);
    stmtSource = conn.prepareStatement(
      "select name, type, line, text from " + source + " " +
      "where name = ? " +
      "  and type = ? " +
      "order by line");
    stmtSource.setFetchSize(ROWS_PREFETCH);
  }

  /** Gets lines of the object DDL */
  public StringBuffer getLines(String type, String name) throws SQLException
  {
    StringBuffer b = new StringBuffer();

    if (type == null || type.length()==0)
      return null;

    //System.out.println("Trying sql");
    //DBSourceExtractor.debug(name.toUpperCase());
    //DBSourceExtractor.debug(type.toUpperCase());

    if (type.equals(TABLE))
    {
      stmtTables.setString(1, name.toUpperCase());
      ResultSet rset = stmtTables.executeQuery();

      // table name
      b.append(CREATE_TABLE);
      b.append(name.toLowerCase());
      b.append(" (");

      String owner = null;

      // table columns
      int rows = 0;
      while (rset.next())
      {
        rows++;
        owner = rset.getString("OWNER");
        String columnName = rset.getString("COLUMN_NAME");
        String dataType = rset.getString("DATA_TYPE");
        String dataLength = rset.getString("DATA_LENGTH");
        String dataPrecision = rset.getString("DATA_PRECISION");
        String dataScale = rset.getString("DATA_SCALE");
        String nullable = rset.getString("NULLABLE");

        StringBuffer columnDesc = new StringBuffer();
        columnDesc.append("  ");
        columnDesc.append(columnName.toLowerCase());
        Utils.pad(columnDesc, 34); // max name length + 2 spaces before + 2 spaces after
        columnDesc.append(dataType);

        // for DATE and NUMBER, data length is not used
        if (dataType.equalsIgnoreCase("NUMBER") || dataType.equalsIgnoreCase("DATE")) {
        
          // assume scale can never be present without precision 
          if (dataPrecision != null) {
            columnDesc.append("(" + dataPrecision);
            if (dataPrecision != null && ! dataPrecision.equals("0") && ! dataScale.equals("0"))
              columnDesc.append("," + dataScale + ")");
            else
              columnDesc.append(')');
          }
          
        }
        // for VARCHAR2 and others, data length IS used
        else {
        
          if (dataLength != null) {
            columnDesc.append("(" + dataLength + ")");
          }
          
        }

        if (nullable != null && nullable.equals("N"))
          columnDesc.append(" NOT NULL");

        if (! rset.isFirst()) {
          b.append(',');
        }
        b.append(Utils.BR);

        b.append(columnDesc);
      }
      rset.close();
      
      // table constraints
      stmtConstraints.setString(1,name.toUpperCase());
      rset = stmtConstraints.executeQuery();
      StringBuffer constraints = new StringBuffer();
      // this counter is needed because we skip some constraints; 
      // otherwise, rset.isFirst() would suffice
      int constraintsAdded = 0; 
      while (rset.next())
      {
        String constraintName = rset.getString("CONSTRAINT_NAME");
        String constraintType = rset.getString("TYPE_NAME").toUpperCase();
        String refOwner = rset.getString("R_OWNER");
        String refConstraint = rset.getString("R_CONSTRAINT_NAME");
        String onDelete = rset.getString("ON_DELETE");
        // skip SYS_... constraints - they aren't needed
        if (constraintName.toUpperCase().startsWith("SYS_")) {
          continue;
        }

        constraintsAdded ++;
        if (constraintsAdded > 1) {
          constraints.append(',');
          constraints.append(Utils.BR);
        }
        constraints.append("  CONSTRAINT ");
        constraints.append(constraintName.toLowerCase());
        constraints.append(' ');
        constraints.append(constraintType);
        constraints.append(' ');

        // print constraint columns except for CHECK constraint)
        if (constraintType.equals("PRIMARY KEY") 
        || constraintType.equals("UNIQUE") 
        || constraintType.equals("FOREIGN KEY")) {

          stmtConsColumns.setString(1, owner.toUpperCase());
          stmtConsColumns.setString(2, constraintName.toUpperCase());
          ResultSet rsetConsColumns = stmtConsColumns.executeQuery();
          StringBuffer constraintColumns = new StringBuffer();
          constraintColumns.append('(');
          while (rsetConsColumns.next())
          {
            if (! rsetConsColumns.isFirst()) {
              constraintColumns.append(',');
              constraintColumns.append(' ');
            }
            constraintColumns.append(rsetConsColumns.getString("COLUMN_NAME").toLowerCase());
          }
          rsetConsColumns.close();
          constraintColumns.append(')');
          constraints.append(constraintColumns);
          
        }
        // for CHECK constraint, print the code
        else  if (constraintType.equals("CHECK")) {
        
          constraints.append('(');
          // get this LONG column only if really needed (for performance reasons)
          constraints.append(rset.getString("SEARCH_CONDITION"));
          constraints.append(')');
          
        }
        else {
        
          throw new IllegalArgumentException("Unknown constraint type: " + constraintType);
          
        }

        // for foreign keys, print referenced primary key columns
        if (constraintType.equals("FOREIGN KEY")) {
        
          constraints.append(Utils.BR);
          constraints.append("    REFERENCES ");
          constraints.append(refOwner.toLowerCase());
          constraints.append('.');

          stmtConsColumns.setString(1, refOwner.toUpperCase());
          stmtConsColumns.setString(2, refConstraint.toUpperCase());
          ResultSet rsetReferencedColumns = stmtConsColumns.executeQuery();
          StringBuffer referencedColumns = new StringBuffer();
          String referencedTable = null;
          while (rsetReferencedColumns.next())
          {
            if (rsetReferencedColumns.isFirst()) {
              // get the referenced table name from here instead of doing additional select from all_constrains; 
              // hope it's the same for all columns
              referencedTable = rsetReferencedColumns.getString("TABLE_NAME").toLowerCase();
            }
            else {
              referencedColumns.append(',');
              referencedColumns.append(' ');
            }
            referencedColumns.append(rsetReferencedColumns.getString("COLUMN_NAME").toLowerCase());
          }
          rsetReferencedColumns.close();

          constraints.append(referencedTable);
          constraints.append(' ');
          constraints.append('(');
          constraints.append(referencedColumns);
          constraints.append(')');
          if (onDelete != null) {
            constraints.append(Utils.BR);
            constraints.append("    ");
            constraints.append(onDelete);
          }
          
        }

      }
      rset.close();

      if (constraints != null && constraints.length() > 0) {
        b.append(Utils.BR);
        b.append(',');
        b.append(Utils.BR);
        b.append(constraints);
      }

      b.append(Utils.BR);
      b.append(')');
      b.append(Utils.BR);

      b.append("/");
      b.append(Utils.BR);

      // table comments
      StringBuffer comments = new StringBuffer();
      stmtTabComments.setString(1, name.toUpperCase());
      ResultSet rsetComments = stmtTabComments.executeQuery();
      while (rsetComments.next())
      {
        String tableComment = rsetComments.getString("COMMENTS");
        if (tableComment != null) {
          comments.append("COMMENT ON TABLE ");
          comments.append(name.toLowerCase());
          comments.append(" IS '");
          comments.append(Utils.adaptQuotes(tableComment));
          comments.append("';");
          comments.append(Utils.BR);
        }
      }
      rsetComments.close();

      // table column comments
      stmtColComments.setString(1, name.toUpperCase());
      ResultSet rsetColComments = stmtColComments.executeQuery();
      while (rsetColComments.next())
      {
        String columnName = rsetColComments.getString("COLUMN_NAME");
        String tableColComment = rsetColComments.getString("COMMENTS");
        if (tableColComment != null) {
          comments.append("COMMENT ON COLUMN ");
          comments.append(name.toLowerCase());
          comments.append('.');
          comments.append(columnName.toLowerCase());
          comments.append(" IS '");
          comments.append(Utils.adaptQuotes(tableColComment));
          comments.append("';");
          comments.append(Utils.BR);
        }
      }
      rsetColComments.close();

      if (comments != null && comments.length() > 0) {
        b.append(Utils.BR);
        b.append(comments);
      }

/* don't extract grants, they are too different
      // grants on the table
      StringBuffer grantsText = new StringBuffer();
      stmtGrants.setString(1, name.toUpperCase());
      ResultSet rsetGrants = stmtGrants.executeQuery();
      while (rsetGrants.next())
      {
        String privilege = rsetGrants.getString("PRIVILEGE");
        String grantor = rsetGrants.getString("GRANTOR");
        String tableName = rsetGrants.getString("TABLE_NAME");
        String grantee = rsetGrants.getString("GRANTEE");
        String grantable = rsetGrants.getString("GRANTABLE");
        grantsText.append("GRANT ");
        grantsText.append(privilege.toUpperCase());
        grantsText.append(" ON ");
        grantsText.append(grantor.toLowerCase());
        grantsText.append('.');
        grantsText.append(tableName.toLowerCase());
        grantsText.append(" TO ");
        grantsText.append(grantee.toLowerCase());
        if (grantable != null && grantable.equalsIgnoreCase("YES")) {
          grantsText.append(" WITH GRANT OPTION ");
        }
        grantsText.append(";");
        grantsText.append(Utils.BR);
      }
      rsetGrants.close();

      if (grantsText != null && grantsText.length() > 0) {
        b.append(Utils.BR);
        b.append(grantsText);
      }
*/
      if (rows == 0)
        return null; // no rows returned
    }
    else if (type.equals(INDEX))
    {
    
      // index name
      int rows = 0;
      stmtIndexes.setString(1, name.toUpperCase());
      ResultSet rset = stmtIndexes.executeQuery();
      while (rset.next())
      {
        rows ++;
        String uniqueness = rset.getString("UNIQUENESS");
        String tableOwner = rset.getString("TABLE_OWNER");
        String tableName = rset.getString("TABLE_NAME");
        // DESCEND is present only since 8i
        String descend = null;
        ResultSetMetaData metaData = rset.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        for (int i = 1; i <= numberOfColumns; i++) {
          if (metaData.getColumnName(i).equalsIgnoreCase("DESCEND")) {
            descend = rset.getString("DESCEND");
          }
        }
        
        b.append("CREATE ");
        if (uniqueness != null && uniqueness.equals("UNIQUE")) {
          b.append("UNIQUE ");
        }
        b.append("INDEX ");
        b.append(name.toLowerCase());
        b.append(" ON ");
        b.append(tableOwner.toLowerCase());
        b.append('.');
        b.append(tableName.toLowerCase());
        b.append(' ');
        b.append('(');

        // index columns
        StringBuffer indColumns = new StringBuffer();
        stmtIndexColumns.setString(1, name.toUpperCase());
        ResultSet rsetIndColumns = stmtIndexColumns.executeQuery();
        while (rsetIndColumns.next())
        {
          if (! rsetIndColumns.isFirst()) {
            indColumns.append(',');
            indColumns.append(Utils.BR);
          }
          indColumns.append("  ");
          indColumns.append(rsetIndColumns.getString("COLUMN_NAME").toLowerCase());
          if (descend != null) {
            Utils.pad(indColumns, 34); // max name length + 2 spaces before + 2 spaces after
            indColumns.append(descend);
          }
        }
        rsetIndColumns.close();
        b.append(Utils.BR);
        b.append(indColumns);

        b.append(Utils.BR);
        b.append(')');
        b.append(Utils.BR);

      }
      rset.close();

      b.append("/");
      b.append(Utils.BR);

      if (rows == 0)
        return null; // no rows returned
    }
    else if (type.equals(SYNONYM))
    {
      stmtSynonyms.setString(1, name.toUpperCase());
      ResultSet rset = stmtSynonyms.executeQuery();

      int rows = 0;
      while (rset.next())
      {
        rows++;
        b.append("CREATE SYNONYM ");
        b.append(name.toLowerCase());
        b.append(" FOR ");
        b.append(rset.getString("TABLE_OWNER").toLowerCase());
        b.append('.');
        b.append(rset.getString("TABLE_NAME").toLowerCase());
        String dbLink = rset.getString("DB_LINK".toLowerCase());
        if (dbLink != null) {
          b.append('@');
          b.append(dbLink);
        }
        b.append(Utils.BR);
      }
      rset.close();

      b.append("/");
      b.append(Utils.BR);

      if (rows == 0)
        return null; // no rows returned
    }
    else if (type.equals(SEQUENCE))
    {
      stmtSequences.setString(1, name.toUpperCase());
      ResultSet rset = stmtSequences.executeQuery();

      int rows = 0;
      while (rset.next())
      {
        rows++;
        String minValue = rset.getString("MIN_VALUE");
        String maxValue = rset.getString("MAX_VALUE");
        String incrementBy = rset.getString("INCREMENT_BY");
        String cycleFlag = rset.getString("CYCLE_FLAG");
        String orderFlag = rset.getString("ORDER_FLAG");
        String cacheSize = rset.getString("CACHE_SIZE");

        b.append("CREATE SEQUENCE ");
        b.append(name.toLowerCase());

        if (minValue != null) {
          b.append(" MINVALUE ");
          b.append(minValue);
        }
        if (maxValue != null) {
          b.append(" MAXVALUE ");
          b.append(maxValue);
        }
        if (incrementBy != null) {
          b.append(" INCREMENT BY ");
          b.append(incrementBy);
        }
        if (cycleFlag != null && cycleFlag.equals("Y")) {
          b.append(" CYCLE");
        } else {
          b.append(" NOCYCLE ");
        }
        if (orderFlag != null && orderFlag.equals("Y")) {
          b.append(" ORDER");
        } else {
          b.append(" NOORDER ");
        }
        if (cacheSize != null && ! cacheSize.equals("0")) {
          b.append(" CACHE ");
          b.append(cacheSize);
        } else {
          b.append(" NOCACHE ");
        }
        b.append(Utils.BR);
      }
      rset.close();

      b.append("/");
      b.append(Utils.BR);

      if (rows == 0)
        return null; // no rows returned
    }
    else if (type.equals(VIEW))
    {
      stmtViews.setString(1, name.toUpperCase());
      ResultSet rset = stmtViews.executeQuery();

      b.append(CREATE_OR_REPLACE_VIEW);
      b.append(name.toLowerCase());
      b.append(AS);
      b.append(Utils.BR);
      
      int rows = 0;
      while (rset.next())
      {
        rows++;
        StringBuffer lines = new StringBuffer(rset.getString("TEXT"));
        // need to trim; there is always an empty line in this field
        b.append(Utils.replaceLineBreaks(lines).toString().trim());
        b.append(Utils.BR);
        b.append("/");
        b.append(Utils.BR);
      }
      rset.close();

      if (rows == 0)
        return null; // no rows returned
    }
    else if (type.equals(TRIGGER))
    {
      b.append(CREATE_OR_REPLACE_TRIGGER); // no new line here

      // trigger name, text      
      stmtTriggers.setString(1, name.toUpperCase());
      ResultSet rset = stmtTriggers.executeQuery();

      int rows = 0;
      while (rset.next())
      {
        rows++;
        // add description
        StringBuffer lines = new StringBuffer(rset.getString("DESCRIPTION"));
        // need to trim; there is always an empty line in this field
        b.append(Utils.replaceLineBreaks(lines).toString().trim());
        // add trigger body
        b.append(Utils.BR);
        lines = new StringBuffer(rset.getString("TRIGGER_BODY"));
        // need to trim; there is always an empty line in this field;
        // each time you extract and create again, new empty line is added
        b.append(Utils.replaceLineBreaks(lines).toString().trim());
        b.append(Utils.BR);
        b.append("/");
        b.append(Utils.BR);
      }
      rset.close();

      if (rows == 0)
        return null; // no rows returned
    }
    else if (type.equals(PACKAGE) || type.equals(PACKAGE_BODY) || 
    type.equals(PROCEDURE) || type.equals(FUNCTION))
    {
      stmtSource.setString(1, name.toUpperCase());
      stmtSource.setString(2, type.toUpperCase());
      ResultSet rset = stmtSource.executeQuery();
      
      b.append(CREATE_OR_REPLACE);
      b.append(Utils.BR);

      int rows = 0;
      while (rset.next())
      {
        rows++;
        StringBuffer lines = new StringBuffer(rset.getString("TEXT"));
        // remove stupid linebreaks at the end of the text
        int pos;
        if ((pos = lines.toString().indexOf(10)) != -1)
          lines.deleteCharAt((new String(lines)).indexOf(10));
        b.append(lines);
        b.append(Utils.BR);
      }
      rset.close();
      
      b.append("/");
      b.append(Utils.BR);

      if (rows == 0)
        return null; // no rows returned
    }
    else {
      throw new IllegalArgumentException("Unknown type '" + type + "'");
    }

    //DBSourceExtractor.debug("sql ok");

    return b;

  }

  protected void finalize() throws Throwable
  {
    stmtViews.close();
    stmtTriggers.close();
    stmtSource.close();
    conn.close();
  }

}