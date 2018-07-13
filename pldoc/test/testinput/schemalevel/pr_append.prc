CREATE OR REPLACE PROCEDURE 
 /**
  *This PROCEDURE appends A string to a CLOB, demonstrating use of NOCOPY parameter option 
  *
  *@param  pa_clob The target CLOB
  *@param  pa_string The string to be appended
  */
pr_append (pa_clob IN OUT NOCOPY CLOB, pa_string IN VARCHAR2) 
IS
BEGIN
  DBMS_LOB.writeappend(pa_clob, LENGTH(pa_string), pa_string); 
END;
/

