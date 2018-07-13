--1146253	Expression - is null not recognized	

CREATE OR REPLACE PROCEDURE
pldoc_bug.testcase_1146263
(x IN OUT pls_integer)
AS
BEGIN

if x is null then
x=1;
end if;

END;
/

