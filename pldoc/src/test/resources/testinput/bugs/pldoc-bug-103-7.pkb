+/v8-CREATE OR REPLACE PACKAGE BODY date+AF8-utilities+AF8-UTF+AF8-7
IS
 
-- Take single parameter, relyimg on current default NLS date format 
FUNCTION to+AF8-date+AF8-single+AF8-parameter (p+AF8-date+AF8-string IN VARCHAR2) RETURN DATE
IS
BEGIN
   RETURN TO+AF8-DATE(p+AF8-date+AF8-string)+ADs 
END to+AF8-date+AF8-single+AF8-parameter +ADs

-- Take 2 parameters, using an explicit date format string  
FUNCTION to+AF8-date+AF8-two+AF8-parameters (p+AF8-date+AF8-string IN VARCHAR2, p+AF8-format+AF8-mask IN VARCHAR2) RETURN DATE
IS
BEGIN
   TO+AF8-DATE(p+AF8-date+AF8-string, p+AF8-date+AF8-format)+ADs 
END to+AF8-date+AF8-two+AF8-parameters +ADs

-- Take 3 parameters, using an explicit date format string and an explicit language    
FUNCTION to+AF8-date+AF8-three+AF8-parameters (p+AF8-date+AF8-string IN VARCHAR2, p+AF8-format+AF8-mask IN VARCHAR2, p+AF8-nls+AF8-language VARCHAR2 ) RETURN DATE
IS
BEGIN
   TO+AF8-DATE(p+AF8-date+AF8-string, p+AF8-format+AF8-mask, p+AF8-nls+AF8-language)+ADs 
END to+AF8-date+AF8-three+AF8-parameters +ADs

END date+AF8-utilities+AF8-UTF+AF8-7 +ADs
/
