

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
prc_conditional IS
 

 
  $IF DBMS_DB_VERSION.VER_LE_9 
  $THEN 
    SUBTYPE my_real IS NUMBER ;
    t  CONSTANT my_real := 0.499975 ; 
    t2 CONSTANT my_real := 2.0 ;
    x  CONSTANT my_real := 1.0 ;
    y  CONSTANT my_real := 1.0 ;
  $ELSE 
    SUBTYPE my_real IS BINARY_DOUBLE ;
    t  CONSTANT my_real := 0.499975d ;
    t2 CONSTANT my_real := 2.0d ;
    x  CONSTANT my_real := 1.0d ;
    y  CONSTANT my_real := 1.0d ;
  $END 

 
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

 PROCEDURE P(x IN my_real, y IN my_real, z OUT NOCOPY my_real) IS
   x1 my_real;
   y1 my_real;
 BEGIN
   x1 := x;
   y1 := y;
   x1 := t * (x1 + y1);
   y1 := t * (x1 + y1);
   z := (
     -- Precompilation Expression within statement 
  $IF DBMS_DB_VERSION.VER_LE_9 
  $THEN 
          x1
  $ELSE 
          y1
  $END 
   + y1)/t2;
 END P;



BEGIN
 P(x, y, z);
 DBMS_OUTPUT.PUT_LINE ('z = '|| z);
END prc_whetstone;
/
  
