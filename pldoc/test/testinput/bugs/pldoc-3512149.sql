CREATE OR REPLACE PACKAGE BODY pldoc_bug.TEST_API_3512149 IS

PROCEDURE Test 
IS
BEGIN
   DBMS_SCHEDULER.create_job
   (
     job_name     => 'test',
     program_name => 'test_api.test',
     enabled      => FALSE
   );

   DBMS_SCHEDULER.set_attribute
   (
     name      => 'test',
     attribute => 'start_date',
     value     => current_timestamp + interval '10' second
   );

END Test;

END;
/
