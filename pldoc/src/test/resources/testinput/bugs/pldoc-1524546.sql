--1524546	DBLink - Problem	

CREATE OR REPLACE PACKAGE pldoc_bug.testcase_1524546 
AS

CURSOR cur_remote IS
SELECT a.number
FROM ACCOUNT@OTDB a
;

END;
/


