


CREATE OR REPLACE PACKAGE pldoc_bug.testcase_bug_release IS

nullif CONSTANT VARCHAR2(4) := 'map';

END;
/

CREATE OR REPLACE PACKAGE BODY pldoc_bug.testcase_bug_release IS

PROCEDURE release 
IS
BEGIN
  dbms_output.put_line (nullif(TESTCONSTANTS.nullif, TO_DATE(TO_CHAR(SYSDATE))) );
END release;

BEGIN
  release;
END;
/


