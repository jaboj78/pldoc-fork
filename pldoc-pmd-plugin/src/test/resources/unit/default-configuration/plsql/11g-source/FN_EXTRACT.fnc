

CREATE OR REPLACE 
FUNCTION fn_extract (pa_parameter_1 NUMBER) RETURN NUMBER RESULT_CACHE IS
extract VARCHAR2(1) ;
BEGIN
   extract := 'Y';
  RETURN ps_parameter_1 * ps_parameter_1   ;
END fn_extract;
/ 


