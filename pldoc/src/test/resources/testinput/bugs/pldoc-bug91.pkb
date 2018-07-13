

CREATE OR REPLACE PACKAGE BODY pldoc_bug.testcase_bug91_3 IS

PROCEDURE Test 
IS

BEGIN

dbms_output.put_line (TESTCONSTANTS.map);

END Test;

END;
/


