--1606375	ParseException - with exponentiation operator (**)	

CREATE OR REPLACE PACKAGE pldoc_bug.testcase_1606375
IS
hugeInteger CONSTANT PLS_INTEGER := 2**31-1;
END kaboom;

