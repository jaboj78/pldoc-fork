

CREATE OR REPLACE 
FUNCTION fn_dot_attach (pa_parameter_1 NUMBER) RETURN NUMBER RESULT_CACHE IS
l_record ty_record_with_attached_field ;
BEGIN
   l_record.attached := 'Y';
  RETURN ps_parameter_1 * ps_parameter_1   ;
END fn_dot_attach;
/ 


