--1606392	ParseException - with new 10g Q function.	

CREATE OR REPLACE PACKAGE pldoc_bug.testcase_1606392
IS
    newfangledString1 VARCHAR2(100) := Q'[
This string uses THE NEW Q FUNCTION!
]';
    newfangledString2 VARCHAR2(100) := Q'"
This string uses THE NEW Q FUNCTION!
"';
END testcase_1606392;
/
