
PROMPT GRANT CREATE DATABASE LINK TO pldoc_bug ;

--DROP DATABASE LINK loopback;
--CREATE DATABASE LINK loopback CONNECT TO  pldoc IDENTIFIED BY pldoc USING 'same_database' ;
-- CREATE DATABASE LINK loopback CONNECT TO CURRENT_USER ;

CREATE OR REPLACE PACKAGE pldoc_bug.testcase_3535118 
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

/**
* REMOTE TYPE.
*/
TYPE remote_row_type IS dual@loopback%ROWTYPE;

/**
Remote CURSOR
*/
CURSOR cur_remote_date IS
SELECT SYSDATE 
FROM DUAL@loopback
;

C_remote_constant CONSTANT remote_row_type := fk_get_table_from_dual@loopback ;
END;
/

SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY pldoc_bug.testcase_3535118 IS
/**
* Testpackage for pldoc bug.
* @headcom
*/

FUNCTION fk_get_table_from_dual
RETURN DUAL@loopback%ROWTYPE IS
t DUAL@loopback%ROWTYPE;
BEGIN
SELECT SYSDATE 
INTO t 
FROM DUAL@loopback;

RETURN t;
END;

BEGIN
-- Package Initialisierung
NULL;
DELETE DUAL@loopback
WHERE 1 = 2
;

UPDATE DUAL@loopback
SET dummy = dummy
WHERE 1 = 2
;

INSERT INTO DUAL@loopback
SELECT dummy
FROM DUAL@loopback
WHERE 1 = 2
;

pkg_remote_package.fk_put_into_dual@loopback ;
pkg_remote_package.fk_put_into_dual@loopback(C_remote_constant) ;
fk_put_into_dual@loopback ;
fk_put_into_dual@loopback(C_remote_constant) ;
END;
/

SHOW ERRORS
