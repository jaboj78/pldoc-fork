


CREATE OR REPLACE PACKAGE pldoc_bug.testcase_bug91_1 IS

nullif CONSTANT VARCHAR2(4) := 'map';

END;
/

CREATE OR REPLACE PACKAGE BODY pldoc_bug.testcase_bug91_1 IS

PROCEDURE Test 
IS

BEGIN

dbms_output.put_line (nullif(TESTCONSTANTS.nullif, TO_DATE(TO_CHAR(SYSDATE))) );

END Test;

END;
/


