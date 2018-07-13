CREATE OR REPLACE PACKAGE BODY date_utilities_UTF_8
IS
 
-- Take single parameter, relyimg on current default NLS date format 
FUNCTION to_date_single_parameter (p_date_string IN VARCHAR2) RETURN DATE
IS
BEGIN
   RETURN TO_DATE(p_date_string); 
END to_date_single_parameter ;

-- Take 2 parameters, using an explicit date format string  
FUNCTION to_date_two_parameters (p_date_string IN VARCHAR2, p_format_mask IN VARCHAR2) RETURN DATE
IS
BEGIN
   TO_DATE(p_date_string, p_date_format); 
END to_date_two_parameters ;

-- Take 3 parameters, using an explicit date format string and an explicit language    
FUNCTION to_date_three_parameters (p_date_string IN VARCHAR2, p_format_mask IN VARCHAR2, p_nls_language VARCHAR2 ) RETURN DATE
IS
BEGIN
   TO_DATE(p_date_string, p_format_mask, p_nls_language); 
END to_date_three_parameters ;

END date_utilities_UTF_8 ;
/
