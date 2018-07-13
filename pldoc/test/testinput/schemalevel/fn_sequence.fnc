

CREATE OR REPLACE fUNCTION 
 /**
  *This fUNCTION returns a sequence number 
  * and is used here as an artificial example to test PLDoc
  * parsing of Oracle conditional compilation keywords in bodies.
  *
  *@return sequence number
  */
fn_sequence 
RETURN NUMBER
IS

  l_initial_value varchar2(30) :=
    $IF DBMS_DB_VERSION.VER_LE_11 
    $THEN 'Not11G'
    $ELSE 
         '11g'
    $END
    ;
  l_sequence NUMBER;
BEGIN 
 

    $IF DBMS_DB_VERSION.VER_LE_11 
    $THEN 
         SELECT fake_sequence.NEXTVAL
         INTO l_sequence 
	 FROM dual;
    $ELSE 
         l_sequence := fake_sequence.NEXTVAL;
    $END
 RETURN l_sequence ;
END fn_sequence;
/
  
