create or replace PROCEDURE truncate_mv_table(pMVName IN VARCHAR2) AS

BEGIN
  FOR C IN (select 'DW_PRES.'||object_name object_name from user_objects
            where object_type = 'MATERIALIZED VIEW'
            ) LOOP
     IF c.object_name = pMVName THEN
        EXECUTE IMMEDIATE 'truncate table '||pMVName;
        EXIT;
     END IF;
  END LOOP;
  COMMIT;
  EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error during truncating '||pMVName);
END;
