

CREATE OR REPLACE 
NONEDITIONABLE
PROCEDURE pr_noneditionable (pa_parameter_1 NUMBER) 
AS
  l_null NUMBER ;
BEGIN
  l_null := ps_parameter_1 * ps_parameter_1 ;
END pr_noneditionable;
/ 


