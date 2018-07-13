

CREATE OR REPLACE 
EDITIONABLE
PROCEDURE prc_accessible (pa_parameter_1 NUMBER) 
ACCESSIBLE BY ( FUNCTION fn_function, PROCEDURE prc_procedure, PACKAGE pkg_package, TRIGGER trg_trigger, TYPE typ_type )
IS
 l_v NUMBER ;
BEGIN
  l_v :=  ps_parameter_1 * ps_parameter_1   ;
END prc_accessible;
/ 


