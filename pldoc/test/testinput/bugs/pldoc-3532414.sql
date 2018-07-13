
PROMPT GRANT CREATE DATABASE LINK TO pldoc_bug ;

--DROP DATABASE LINK loopback;
--CREATE DATABASE LINK loopback CONNECT TO  pldoc IDENTIFIED BY pldoc USING 'same_database' ;
-- CREATE DATABASE LINK loopback CONNECT TO CURRENT_USER ;

CREATE OR REPLACE PACKAGE pldoc_bug.testcase_3532414 
IS
/**
* Bug 3532414 - Parsing error when function return type contains a database link (@) 
* @headcom
*/

/**
* Testcase for pldoc bug.
* @return dual.
*/
FUNCTION fk_get_table_from_dual RETURN dual@loopback%ROWTYPE;

END;
/

SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY pldoc_bug.testcase_3532414 IS
/**
* Testpackage for pldoc bug.
* @headcom
*/

FUNCTION fk_get_table_from_dual
RETURN DUAL@loopback%ROWTYPE IS
t DUAL@loopback%ROWTYPE;
BEGIN
SELECT SYSDATE INTO t FROM DUAL@loopback;

RETURN t;
END;

BEGIN
-- Package Initialisierung
NULL;
END;
/

SHOW ERRORS
