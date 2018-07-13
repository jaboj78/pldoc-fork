
CREATE OR REPLACE PACKAGE pldoc_bug.testcase_bug91_4 IS

map CONSTANT VARCHAR2(4) := 'map';

END;
/

CREATE OR REPLACE PACKAGE BODY pldoc_bug.testcase_bug91_4 IS

PROCEDURE Test 
IS

BEGIN

dbms_output.put_line (TESTCONSTANTS.map);

END Test;

END;
/

