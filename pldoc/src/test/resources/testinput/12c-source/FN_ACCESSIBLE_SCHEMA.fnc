

CREATE OR REPLACE 
EDITIONABLE
FUNCTION fn_accessible_schema (pa_parameter_1 NUMBER) RETURN NUMBER RESULT_CACHE 
ACCESSIBLE BY ( other_schema.fn_function, other_schema.prc_procedure, other_schema.pkg_package, other_schema.trg_trigger, other_schema.typ_type )
IS
BEGIN
  RETURN ps_parameter_1 * ps_parameter_1   ;
END fn_accessible_schema;
/ 


