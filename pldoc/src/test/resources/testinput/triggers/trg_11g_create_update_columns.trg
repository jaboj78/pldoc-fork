CREATE OR REPLACE TRIGGER trg_update_columns
/* Update of named columns. 
* 
* 
*/
BEFORE UPDATE OF a,b,c,d,e OR INSERT  ON trigger_control_test
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.put_line('TRIGGER_CONTROL_TEST_TRG - Executed');
END;
/



