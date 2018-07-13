

CREATE OR REPLACE 
EDITIONABLE
FUNCTION fn_editionable (pa_parameter_1 NUMBER) RETURN NUMBER RESULT_CACHE IS
BEGIN
  RETURN ps_parameter_1 * ps_parameter_1   ;
END fn_editionable;
/ 


