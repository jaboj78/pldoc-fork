


CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_multiset IS
  /**
  *<PRE>In the meantime I found some more issues, TRIM may contain
  *\"LEADING\" or \"TRAILING\" instead of \"RIGHT\" and \"LEFT\"
  *\"RELIES_ON\" was also not supported.
  *</PRE>
  *
  *<p>
  *Example statement:
  *Condition:
  *</p>
  *<p>
  *<pre>
  * table1 MULTISET ( EXCEPT | INTERSECT | UNION )   [ DISTINCT | ALL ] table2
  *</pre>
  *</p>
  *@see http://docs.oracle.com/cd/B28359_01/server.111/b28286/operators006.htm
  *@headcom
  */

   TYPE PclBitmapTableType IS TABLE OF PLS_INTEGER;

  /**
  * Test TRIM in SQL.
  */
  PROCEDURE testcase;

  /**
  * Test TRIM in PL/SQL.
  */
  FUNCTION GenParClassId(PclBitmapTable IN PclBitmapTableType)
	RETURN T_PARAMETERS.PAR_PCL_ID%TYPE ;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pldoc_bug.testcase_3469812_trim IS

	PclBitmapMaster PclBitmapTableType := PclBitmapTableType(1,2,3);

  PROCEDURE testcase IS
    l_customer_id customers_demo.customer_id%TYPE;
    l_cust_address_ntab customers_demo.cust_address_ntab%TYPE;
  BEGIN
    SELECT customer_id, cust_address_ntab
    INTO l_customer_id, l_cust_address_ntab
    FROM customers_demo
    WHERE cust_address_typ('8768 N State Rd 37', 47404, 
    'Bloomington', 'IN', 'US')
    MEMBER OF cust_address_ntab
    AND
    (
       LENGTH(TRIM ( cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( LEADING FROM cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( trailing FROM cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( Both FROM cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( '0' FROM cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( leading '1' FROM cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( trailing '2' FROM cust_address_ntab.post_code )  ) > 0 
    OR LENGTH(TRIM ( Both '3' FROM cust_address_ntab.post_code )  ) > 0 
    )
    ORDER BY customer_id;
  END;

		
FUNCTION GenParClassId(PclBitmapTable IN PclBitmapTableType)
	RETURN T_PARAMETERS.PAR_PCL_ID%TYPE IS

	res T_PARAMETERS.PAR_PCL_ID%TYPE := 0;
	
        our_employees strings_nt := strings_nt();
BEGIN
      our_employees := employees_pkg.vancouver_employees
                     MULTISET UNION employees_pkg.newyork_employees;

      employees_pkg.show_employees ('MINE then VEVA', our_employees);

      our_employees := employees_pkg.newyork_employees
                     MULTISET UNION ALL employees_pkg.vancouver_employees;

      employees_pkg.show_employees ('VEVA then MINE', our_employees);

      our_employees := employees_pkg.vancouver_employees
                     MULTISET UNION DISTINCT employees_pkg.newyork_employees;

      our_employees := employees_pkg.vancouver_employees
                     MULTISET EXCEPT employees_pkg.newyork_employees;

      employees_pkg.show_employees ('MINE then VEVA', our_employees);

      our_employees := employees_pkg.newyork_employees
                     MULTISET EXCEPT ALL employees_pkg.vancouver_employees;

      employees_pkg.show_employees ('VEVA then MINE', our_employees);

      our_employees := employees_pkg.vancouver_employees
                     MULTISET EXCEPT DISTINCT employees_pkg.newyork_employees;

      employees_pkg.show_employees ('MINE then VEVA with DISTINCT', our_employees);


      our_employees := employees_pkg.vancouver_employees
                     MULTISET INTERSECT employees_pkg.newyork_employees;

      employees_pkg.show_employees ('MINE then VEVA', our_employees);

      our_employees := employees_pkg.newyork_employees
                     MULTISET INTERSECT ALL employees_pkg.vancouver_employees;

      employees_pkg.show_employees ('VEVA then MINE', our_employees);

      our_employees := employees_pkg.vancouver_employees
                     MULTISET INTERSECT DISTINCT employees_pkg.newyork_employees;

	IF PclBitmapTable IS NULL THEN
		RETURN NULL;
	END IF;
	
	IF PclBitmapTable.COUNT > 0 THEN
		FOR i IN PclBitmapMaster.FIRST..PclBitmapMaster.LAST LOOP
			IF LENGTH(TRIM ( res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( LEADING FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( trailing FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( Both FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( '0' FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( leading '1' FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( trailing '2' FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF LENGTH(TRIM ( Both '3' FROM res )  ) > 0 
			THEN
				res := res + POWER(2, i-1);
			END IF;
		END LOOP;		
		RETURN res;
	ELSE
		-- All Bits disabled
		RETURN 0;
	END IF;

END GenParClassId;

END ;
/
