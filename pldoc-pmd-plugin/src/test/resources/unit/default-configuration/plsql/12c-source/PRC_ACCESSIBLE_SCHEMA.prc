

CREATE OR REPLACE 
EDITIONABLE
PROCEDURE prc_accessible (pa_parameter_1 NUMBER) 
ACCESSIBLE BY ( FUNCTION other_schema1.fn_function, PROCEDURE other_schema2.prc_procedure, PACKAGE other_schema3.pkg_package, TRIGGER other_schema3.trg_trigger, TYPE other_schema4.typ_type )
IS
 l_v NUMBER ;
BEGIN
  l_v :=  ps_parameter_1 * ps_parameter_1   ;
END prc_accessible;
/ 


