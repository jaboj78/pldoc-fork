

CREATE OR REPLACE 
EDITIONABLE
FUNCTION fn_accessible (pa_parameter_1 NUMBER) RETURN NUMBER RESULT_CACHE 
ACCESSIBLE BY ( fn_function, prc_procedure, pkg_package, trg_trigger, typ_type )
IS
BEGIN
  RETURN ps_parameter_1 * ps_parameter_1   ;
END fn_accessible;
/ 


