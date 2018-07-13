


CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_3472934 IS

 /** This form appears in SYS.STANDARD SUBTYPE pldoc_integer IS INTEGER RANGE '-20' .. 20; */

 SUBTYPE literal_integer is integer range '-20' ..20;
 
 /** SUBTYPE pldoc_integer IS PLS_INTEGER RANGE -999..999; */
 SUBTYPE pldoc_integer IS PLS_INTEGER RANGE -999..999;

 /** Initial value */
 g_var pldoc_integer DEFAULT -1 ;

 END;
/

