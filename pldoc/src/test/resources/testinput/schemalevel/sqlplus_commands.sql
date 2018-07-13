--scott/tiger


--COMMENT ON dummy is 'I am a dummy comment';

SPOOL sqlplus.out 


SET ECHO ON 
SET SERVEROUTPUT ON
VARIABLE b_clob CLOB


EXECUTE :b_clob := fn_get_clob('SELECT * FROM DUAL');

PRINT :b_clob

CONNECT sys/change_on_install

@sqlscript

SHOW ERRORS 

@@sqlscript

COLUMN dummy FORMAT A50

SELECt *
FROM DUAL
/




PROMPT This is a message 

ACCEPT v_dummy PROMPT "Press any key to continue: "

SHOW ALL

GRANT SELECT ON dual to PUBLIC; 

ALTER SESSION SET NLS_DATE_FORMAT='American' ;

DROP TABLE NO_SUCH_TABLE

REVOKE SWIMMER FROM DIVER;


-- NEWLINE WHITESPACE* SQLPLUS command read up to and including end of line 


DEFINE v_variable="I am defined"  
UNDEFINE v_variable  

DECLARE
DEFINE VARCHAR2(30) :="I am defined"  ;
UNDEFINE VARCHAR2(30) :="I am undefined"  ;
BEGIN
NULL;
END;
/







DECLARE
DEFINE VARCHAR2(30) :="I am defined"  ;
UNDEFINE VARCHAR2(30) :="I am undefined"  ;
BEGIN
NULL;
END;
/














