CREATE OR REPLACE TRIGGER trg_create_enabled
/* DBMS_METADATA.GET_DDL retrieves an (Imported?/Recompiled?) trigger as 2 DDL statements. 
* 
* 
*<ul>
*<p><li>CREATE TRIGGER statement</li>;</p>
*<p><li>ALTER TRIGGER ENABLE/DISABLE statement.  
*</ul> 
*
*
*@see  http://download.oracle.com/docs/cd/B28359_01/appdev.111/b28370/alter_trigger.htm#LNPLS99996
*/
BEFORE INSERT ON trigger_control_test
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.put_line('TRIGGER_CONTROL_TEST_TRG - Executed');
END;
/
ALTER TRIGGER trg_create_enabled ENABLE; 



