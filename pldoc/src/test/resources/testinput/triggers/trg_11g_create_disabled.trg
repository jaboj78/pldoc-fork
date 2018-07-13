CREATE OR REPLACE TRIGGER trg_create_disabled
BEFORE INSERT ON trigger_control_test
FOR EACH ROW
DISABLE -- 11G Syntax Other keyword is ENABLE (default)
BEGIN
  DBMS_OUTPUT.put_line('TRIGGER_CONTROL_TEST_TRG - Executed');
END;
/



