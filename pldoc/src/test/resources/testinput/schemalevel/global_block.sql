SET SERVEROUTPUT ON 

/** A named PL/SQL Block 
*/
<<NAMED_BLOCK>>
<<NAMED_BLOCK>>
<<NAMED_BLOCK>>
<<NAMED_BLOCK>>
<<NAMED_BLOCK>>
DECLARE
  G_constant CONSTANT VARCHAR2(30) := 'NAMED_BLOCK';
  BEGIN
      dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': Block Label is "' ||G_CONSTANT || '"' );
      <<OUTER_LOOP>>
      FOR o IN 1 .. 2
      LOOP
        <<INNER_LOOP>>
        FOR i IN 1 .. 2
        LOOP
          dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': outer_loop=' || o || ', inner_loop=' ||i);
        END LOOP inner_loop;
      END LOOP outer_loop;
END named_block;
/


/** An anonymous PL/SQL Block 
*/
DECLARE
  G_constant CONSTANT VARCHAR2(30) := '1st Anonymous BLOCK';
  SUBTYPE unqualified_name IS VARCHAR2(30) NOT NULL;
  BEGIN
      dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': Block Label is "' ||G_CONSTANT || '"' );
      <<OUTER_LOOP>>
      FOR o IN 1 .. 2
      LOOP
        <<INNER_LOOP>>
        FOR i IN 1 .. 2
        LOOP
          dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': outer_loop=' || o || ', inner_loop=' ||i);
        END LOOP inner_loop;
      END LOOP outer_loop;
END;
/

/** Another anonymous PL/SQL Block 
*/
DECLARE
  G_constant CONSTANT VARCHAR2(30) := '2nd Anonymous BLOCK';
  BEGIN
      dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': Block Label is "' ||G_CONSTANT || '"' );
      <<OUTER_LOOP>>
      FOR o IN 1 .. 2
      LOOP
        <<INNER_LOOP>>
        FOR i IN 1 .. 2
        LOOP
          dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': outer_loop=' || o || ', inner_loop=' ||i);
        END LOOP inner_loop;
      END LOOP outer_loop;
END;
/


/** A named PL/SQL Block 
*/
<<NAMED_BLOCK>>
DECLARE
  G_constant CONSTANT VARCHAR2(30) := 'NAMED_BLOCK';
  BEGIN
      dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': Block Label is "' ||G_CONSTANT || '"' );
      <<OUTER_LOOP>>
      FOR o IN 1 .. 2
      LOOP
        <<INNER_LOOP>>
        FOR i IN 1 .. 2
        LOOP
          dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': outer_loop=' || o || ', inner_loop=' ||i);
        END LOOP inner_loop;
      END LOOP outer_loop;
END named_block;
/

/** A named PL/SQL Block 
*/
<<NAMED_$#BLOCK>>
DECLARE
  G_constant CONSTANT VARCHAR2(30) := '<<NAMED_$#BLOCK>>';
  BEGIN
      dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': Block Label is "' ||G_CONSTANT || '"' );
      <<OUTER_LOOP>>
      FOR o IN 1 .. 2
      LOOP
        <<INNER_LOOP>>
        FOR i IN 1 .. 2
        LOOP
          dbms_output.put_line('$$PLSQL_UNIT='||$$PLSQL_UNIT||', $$PLSQL_LINE='||$$PLSQL_LINE||': outer_loop=' || o || ', inner_loop=' ||i);
        END LOOP inner_loop;
      END LOOP outer_loop;
END named_b$#lock;
/

exit 0
