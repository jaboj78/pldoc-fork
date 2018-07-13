--1211416	Stand-alone - procedures cannot be parsed	


CREATE OR REPLACE PROCEDURE 
 /**
  *This PROCEDURE defines a Whetstone benchmark 
  * {@link http://en.wikipedia.org/wiki/Whetstone_%28benchmark%29 Whetstone (benchmark)},
  * and is used here to test PLDoc
  * parsing of Oracle conditional compilation keywords.
  *
  *<p>Notice that conditional compilation constructs
  * can interrupt a regular PL/SQL statement.
  * You can locate a conditional compilation directive anywhere
  * there is whitespace in the regular statement.
  *</p>
  *
  *@see http://download.oracle.com/docs/cd/B19306_01/appdev.102/b14258/d_dbver.htm
  */
pldoc_bug.testcase_1211416 IS
 

 SUBTYPE my_real IS
    $IF DBMS_DB_VERSION.VER_LE_9 $THEN NUMBER
                                 $ELSE BINARY_DOUBLE
    $END;

 t  CONSTANT my_real := $IF DBMS_DB_VERSION.VER_LE_9 $THEN 0.499975 
                                                     $ELSE 0.499975d 
                        $END;

 t2 CONSTANT my_real := $if DBMS_DB_VERSION.VER_LE_9 $THEN 2.0
                                                     $ELSE 2.0d
                        $END;

 x  CONSTANT my_real := $IF DBMS_DB_VERSION.VER_LE_9 $THEN 1.0
                                                     $ELSE 1.0d
                        $END;

 y  CONSTANT my_real := $IF DBMS_DB_VERSION.VER_LE_9 $THEN 1.0
                                                     $ELSE 1.0d
                        $END;
 
 z  MY_REAL;
 
 PROCEDURE P(x IN my_real, y IN my_real, z OUT NOCOPY my_real) IS
   x1 my_real;
   y1 my_real;
 BEGIN
   x1 := x;
   y1 := y;
   x1 := t * (x1 + y1);
   y1 := t * (x1 + y1);
   z := (x1 + y1)/t2;
 END P;
BEGIN
 P(x, y, z);
 DBMS_OUTPUT.PUT_LINE ('z = '|| z);
END prc_whetstone;
/
  

