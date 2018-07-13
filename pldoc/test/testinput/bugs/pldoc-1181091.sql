--1181091	Problem - parsing multiple levels of redirect in declarations	


CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_11181091
AS

PROCEDURE
p_procedure (
 p_language_id IN gtd.LANGUAGE.language_id%TYPE
);
END;
/


