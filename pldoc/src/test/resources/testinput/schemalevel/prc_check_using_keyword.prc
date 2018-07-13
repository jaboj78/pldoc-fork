
PROCEDURE 
/**
* Ensure that the USING keyword may be used as a variable and a sytactic keyword.
**/
prc_check_using_keyword (p_sql VARCHAR2, p_bind_1 VARCHAR2 , p_bind_2 VARCGAR) 
IS
USING VARCHAR2(2000);
BEGIN
EXECUTE IMMEDIATE  p_sql USING p_bind_1, p_bind_2 ;
END;
