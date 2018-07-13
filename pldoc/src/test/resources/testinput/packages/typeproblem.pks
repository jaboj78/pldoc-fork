CREATE OR REPLACE PACKAGE type_problem
IS

TYPE test_type IS no_such_table.id%TYPE;
TYPE test_row_type IS no_such_table%ROWTYPE;

TYPE my_ref_cursor IS SYS_REFCURSOR;

TYPE DATE IS DATE_BASE;

TYPE VARCHAR2(30);
END;
/


