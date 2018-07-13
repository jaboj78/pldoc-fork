CREATE OR REPLACE PROCEDURE  
/** Demonstrate INLINE PRAGMA problem.
 *
 */
pldoc_testcase_00101
AS
 /** Number of iterations */
 l_loops  CONSTANT NUMBER := 10000000;
 /** Start value - dependent on start time */
 l_start  NUMBER;
 /** Final value  */
 l_return NUMBER;

 /**
  * Inline as an identifier. 
  */
 inline NUMBER;

 /**
  * Inline as an identifier. 
  */
PROCEDURE inline
IS
BEGIN
  NULL;
END inline;
 
FUNCTION 
/** Add 2 numbers.
 *
 * @param p1 first number 
 * @param p_2 second number 
 * @return sum of <i>p1</i> and <i>p2<i>
 */
add_numbers (p_1 IN NUMBER, p_2 IN NUMBER) RETURN NUMBER AS
BEGIN
  RETURN p_1 + p_2;
END add_numbers;

BEGIN
  l_start := dbms_utility.get_time;

  
  FOR i IN 1 .. l_loops LOOP
    PRAGMA INLINE (add_numbers, 'YES');
    l_return := add_numbers(1, i);
  END LOOP;

  dbms_output.put_line('Elapsed Time: ' || (dbms_utility.get_time - l_start) || ' hsecs');
END;
/

