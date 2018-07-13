CREATE OR REPLACE TYPE pldoc_bug.testcase_109 AS OBJECT (

	/**
	 * Cope with working/compiling but (currently) undocumented extended PIPELINED syntax  
	 *
	 * The documentation for {@link http://docs.oracle.com/database/121/LNPLS/create_type.htm#i2121991 CREATE TYPE}
	 * and {@link http://docs.oracle.com/database/121/LNPLS/create_type_body.htm#LNPLS2185 CREATE TYPE BODY} 
	 * syntax diagrams have little information about extended PIPELINED clauses. 
	 * 
	 *@headcom
	 */

	ROUTE VARCHAR2(400),
	PRIORITY NUMBER,
	static function bug_table(str clob, paths bug_varray, names bug_varray := null) 
	return anydataset 
	pipelined using bug_table_impl
)
/


