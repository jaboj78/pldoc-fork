
PROCEDURE 
/**
* Ensure that the USING keyword may be used as a variable and a sytactic keyword.
**/
c##common_user.prc_common_user (p_sql VARCHAR2, p_bind_1 VARCHAR2 , p_bind_2 VARCGAR) 
IS
TYPE ty_varchars_tab IS TABLE OF VARCHAR2(30);
USING VARCHAR2(2000);
v1 VARCHAR2(30);
v2 VARCHAR2(30);
v3 VARCHAR2(30);
v_tab ty_varchar2_tab;
BEGIN
	-- http://docs.oracle.com/cd/B19306_01/appdev.102/b14261/executeimmediate_statement.htm
EXECUTE IMMEDIATE  p_sql USING p_bind_1, p_bind_2 ;

--INTO 
EXECUTE IMMEDIATE p_sql INTO v1, v2 USING p_bind_1, p_bind_2 ;
-- BULK COLLECT
EXECUTE IMMEDIATE p_sql BULK COLLECT INTO v_tab USING p_bind_1, p_bind_2 ;

--RETURNING 
--INTO 
EXECUTE IMMEDIATE p_sql INTO v1, v2 USING p_bind_1, p_bind_2 RETURNING INTO v3;
-- BULK COLLECT
EXECUTE IMMEDIATE p_sql BULK COLLECT INTO v_tab USING p_bind_1, p_bind_2 RETURNING BULK COLLECT INTO v_tab;
END;
/



