


CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_3469812 IS
  /**
   *Multiset Conditions (e.g. MEMBER OF) are not know by the parser:
  *</pre>
  *<code>
  *net.sourceforge.pldoc.parser.ParseException: Encountered "MEMBER" at line 21, column 47.
  *Was expecting one of:
  *"/" ...
  *"=" ...
  *"!" ...
  *"<" ...
  *">" ...
  *"+" ...
  *"-" ...
  *"||" ...
  *"**" ...
  *"*" ...
  *"AND" ...
  *"BETWEEN" ...
  *"FROM" ...
  *"IN" ...
  *"IS" ...
  *"LIKE" ...
  *"MOD" ...
  *"NOT" ...
  *"OR" ...
  *"THEN" ...
  *"." ...
  *"(" ...
  *":" ...
  *
  *at net.sourceforge.pldoc.parser.PLSQLParser.generateParseException(PLSQLParser.java:31615)
  *at net.sourceforge.pldoc.parser.PLSQLParser.jj_consume_token(PLSQLParser.java:31462)
  *at net.sourceforge.pldoc.parser.PLSQLParser.statement(PLSQLParser.java:8374)
  *at net.sourceforge.pldoc.parser.PLSQLParser.statement(PLSQLParser.java:8994)
  *at net.sourceforge.pldoc.parser.PLSQLParser.statement(PLSQLParser.java:8377)
  *at net.sourceforge.pldoc.parser.PLSQLParser.programUnit(PLSQLParser.java:5770)
  *at net.sourceforge.pldoc.parser.PLSQLParser.declarativeUnit(PLSQLParser.java:2166)
  *at net.sourceforge.pldoc.parser.PLSQLParser.declarativeSection(PLSQLParser.java:2534)
  *at net.sourceforge.pldoc.parser.PLSQLParser.packageBody(PLSQLParser.java:1612)
  *at net.sourceforge.pldoc.parser.PLSQLParser.input(PLSQLParser.java:630)
  *at net.sourceforge.pldoc.PLDoc.processPackage(PLDoc.java:489)
  *at net.sourceforge.pldoc.PLDoc.run(PLDoc.java:190)
  *at net.sourceforge.pldoc.PLDoc.main(PLDoc.java:124)
  *Package d:\Temp\Pmd_parameter.sql skipped.
  *</code>
  *</pre>
  *
  *<p>
  *Example statement:
  *</p>
  *<p>
  *<pre>
  *<code>
  *SELECT customer_id, cust_address_ntab
  *FROM customers_demo
  *WHERE cust_address_typ('8768 N State Rd 37', 47404, 
  *'Bloomington', 'IN', 'US')
  *MEMBER OF cust_address_ntab
  *ORDER BY customer_id;
  *</code>
  *</pre>
  *</p>
  *
  *<p>
  *Condition:
  *</p>
  *<p>
  *<pre>
  *nested_table <IS> [ NOT ] ( <EMPTY> | <A> <SET> ) 
  *nested_table [ <NOT> ] ( <MEMBER> | <SUBMULTISET> ) <OF> nested_table2
  *</pre>
  *</p>
  *@see http://docs.oracle.com/cd/B28359_01/server.111/b28286/conditions006.htm
  *@headcom
  */

   TYPE PclBitmapTableType IS TABLE OF PLS_INTEGER;

  /**
  * Test MULTISET CONDITIONS in SQL.
  */
  PROCEDURE testcase;

  /**
  * Test MULTISET CONDITIONS in PL/SQL.
  */
  FUNCTION GenParClassId(PclBitmapTable IN PclBitmapTableType)
	RETURN T_PARAMETERS.PAR_PCL_ID%TYPE ;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pldoc_bug.testcase_3469812 IS

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
    ORDER BY customer_id;
  END;

		
FUNCTION GenParClassId(PclBitmapTable IN PclBitmapTableType)
	RETURN T_PARAMETERS.PAR_PCL_ID%TYPE IS

	res T_PARAMETERS.PAR_PCL_ID%TYPE := 0;
	
BEGIN
	IF PclBitmapTable IS NULL THEN
		RETURN NULL;
	END IF;
	
	IF PclBitmapTable.COUNT > 0 THEN
		FOR i IN PclBitmapMaster.FIRST..PclBitmapMaster.LAST LOOP
			IF PclBitmapMaster(i) IS EMPTY
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF PclBitmapMaster(i) IS A SET 
			THEN
				res := res + POWER(2, i-1);
			END IF;
			IF PclBitmapMaster(i) MEMBER OF PclBitmapTable THEN
				res := res + POWER(2, i-1);
			END IF;
			IF PclBitmapMaster(i) SUBMULTISET OF PclBitmapTable THEN
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
