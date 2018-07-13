create or replace package pldoc_bug.testcase_3521945 is

	/** Legal variant of {@link http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions197.htm TRANSLATE} */ 
	G_translated_String CONSTANT VARCHAR2(240) := translate('A'  using char_cs);
	/** Legal variant of {@link http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions197.htm TRANSLATE} */ 
	G_translated_NString CONSTANT VARCHAR2(240) := translate('A'  using Nchar_cs);
	/** Legal variant of {@link http://docs.oracle.com/cd/B14117_01/server.101/b10759/functions018.htm CHR} */ 
	G_CHR_NString CONSTANT VARCHAR2(240) := CHr(20 using Nchar_cs);
	/** <b>Illegal</b> variant of {@link http://docs.oracle.com/cd/B14117_01/server.101/b10759/functions018.htm CHR} - allowed in PLDoc to make parser easier */ 
	G_CHR_String CONSTANT VARCHAR2(240) := CHr(20 using char_cs);

	/** Test in code use of <code>translate( USING CHAR_CS|NCHAR_CS)</code>
	 *@see http://docs.oracle.com/cd/B14117_01/server.101/b10759/functions018.htm
	 *@see http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions197.htm
	*/
	procedure test;

end;
/

create or replace package body pldoc_bug.testcase_3521945 is


	/** Test in code use of <code>translate( USING CHAR_CS|NCHAR_CS)</code>
	 *@see http://docs.oracle.com/cd/B14117_01/server.101/b10759/functions018.htm
	 *@see http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions197.htm
	*/
	procedure test is
		vcString varchar2(10);
		nvcString nvarchar2(10);
	begin
	
		vcString := 'Test';
		nvcString := translate(vcString using nchar_cs);
		
	end;
	
end;
/
