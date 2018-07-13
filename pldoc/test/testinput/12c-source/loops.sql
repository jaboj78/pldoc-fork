CREATE OR REPLACE
PACKAGE "test_schema".pldoc_loops
IS


PROCEDURE function (function10 number);


END;
/

CREATE OR REPLACE
PACKAGE BODY "test_schema".pldoc_loops
IS
/**
 * Continue: 
 * CONTINUE: 
 * 
 * Exit: 
 * EXIT; 
 * EXIT WHEN expression | value ; 
 * EXIT; 
 * 
 * Goto: 
 * GOTO label; 
 * 
 */
PROCEDURE function (function10 number)
IS
  cursor function is 
    select * from dual;
BEGIN
  <<loop1>>
  for function in 1..100 loop
	  <<loop2>>
	  for function in 1..100 loop
	    null;
	    case function
	    when 90 then continue ;
	    else null;
	    end case;
	    continue when function = 80 ; 
	    continue when loop1.function = 70 ; 
	    continue loop1 when loop1.function = 75 ; 
	    exit when loop1.function = 80 ; 
	  end loop loop2;
    continue when function = 80 ; 
    null;
    if function > 90
    then
       goto finished ;
    end if;
  end loop loop1;
  <<finished>>
  NULL;
END;
END;
/


