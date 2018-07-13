DECLARE
  l_source  DBMS_SQL.VARCHAR2A;
  l_wrap    DBMS_SQL.VARCHAR2A;
BEGIN
  L_SOURCE(1) := 'CREATE OR REPLACE FUNCTION ';
  L_SOURCE(2) := CHR(10) ||'/** Return SYSDATE formatted using the provided template. ';
  L_SOURCE(3) := CHR(10)||' *  ';
  L_SOURCE(4) := CHR(10)||' *  ';
  L_SOURCE(5) := CHR(10)||' *  @param p_date_format normal TO_CHARE/TO_DATE date template ';
  L_SOURCE(6) := CHR(10)||' *  @return formatted datestring ';
  L_SOURCE(7) := CHR(10)||' *  @see http://www.oracle-base.com/articles/10g/WrapAndDBMS_DDL_10gR2.php#dbms_ddl ';
  L_SOURCE(8) := CHR(10)||' */ ';
  L_SOURCE(9) := CHR(10)||'get_date_string(p_date_format VARCHAR) RETURN VARCHAR2 AS ';
  L_SOURCE(10) := CHR(10)||'BEGIN ';
  L_SOURCE(11) := CHR(10)||'RETURN TO_CHAR(SYSDATE, p_date_format); ';
  l_source(12) := CHR(10)||'END get_date_string;';

  SYS.DBMS_DDL.CREATE_WRAPPED(ddl => l_source,
                              lb  => 1,
                              ub  => l_source.count);
END;
/

SHOW ERRORS 


SET PAGESIZE 100


SELECT text
FROM   user_source
WHERE  name = 'GET_DATE_STRING'
AND    type = 'FUNCTION'
;


select 
--* 
/*
  FUNCTION get_ddl (
                object_type     IN  VARCHAR2,
                name            IN  VARCHAR2,
                schema          IN  VARCHAR2 DEFAULT NULL,
                version         IN  VARCHAR2 DEFAULT 'COMPATIBLE',
                model           IN  VARCHAR2 DEFAULT 'ORACLE',
                transform       IN  VARCHAR2 DEFAULT 'DDL')
        RETURN CLOB;
*/
dbms_metadata.get_ddl(object_type, object_name, owner)
from dba_objects
WHERE OBJECT_NAME = 'GET_DATE_STRING'
AND object_TYPE = 'FUNCTION'
AND owner = USER
--ORDER BY line
;

