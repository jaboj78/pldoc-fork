CREATE OR REPLACE TRIGGER trg_11g_non_dml_schema
AFTER LOGON ON test_user.SCHEMA 
DISABLE -- 11G Syntax Other keyword is ENABLE (default)
BEGIN
  DBMS_OUTPUT.put_line('TRIGGER_CONTROL_TEST_TRG - Executed');
END trg_11g_non_dml_schema;
/



