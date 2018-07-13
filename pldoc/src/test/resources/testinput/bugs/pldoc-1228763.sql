--1228763	NVL - in order by not accepted	

CREATE OR REPLACE PACKAGE pldoc_bug.testcase_1228763 IS

CURSOR c_main_loop IS
SELECT one,
       two,
       three
  FROM xyzzy
 ORDER BY NVL(one,'1');

END;
/

