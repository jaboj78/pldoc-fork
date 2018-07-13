


CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_range IS


 SUBTYPE pldoc_integer_nullable IS PLS_INTEGER RANGE -127..+127;
 SUBTYPE pldoc_integer IS PLS_INTEGER RANGE -127..+127 NOT NULL;

 g_var  pldoc_integer := -0;
 g_var_minus_one pldoc_integer := g_var-1  ;
 g_var_plus_one pldoc_integer := g_var+1  ;

 g_plus_one pldoc_integer := +1  ;
 g_plus_one_plus_one pldoc_integer := +1+1  ;
 g_plus_one_minus_one pldoc_integer := +1-1  ;
 g_plus_one_minus_minus_one pldoc_integer := +1- -1  ;
 g_plus_one_plus_minus_one pldoc_integer := +1+-1  ;
 g_plus_one_plus_plus_one pldoc_integer := +1++1  ;
 g_plus_one_minus_plus_one pldoc_integer := +1-+1  ;



 g_minus_one pldoc_integer := -1  ;
 g_minus_one_plus_one pldoc_integer := -1+1  ;
 g_minus_one_minus_one pldoc_integer := -1-1  ;
 g_minus_one_minus_minus_one pldoc_integer := -1- -1  ;
 g_minus_one_plus_minus_one pldoc_integer := -1+-1  ;
 g_minus_one_plus_plus_one pldoc_integer := -1++1  ;
 g_minus_one_minus_plus_one pldoc_integer := -1-+1  ;



 g_var_negative_precision number(10,-2) := 200  ;

 g_var_ten_to_minus2 number := 10**(-2)  ;
 END;
/

