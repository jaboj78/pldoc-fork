SET DEFINE OFF

CREATE OR REPLACE
TYPE BODY ty_logger AS 
/*
m_loggername       CONSTANT VARCHAR2(100)   := 'logging.ty_logger'
--STATIC m_threadname       CONSTANT VARCHAR2(100)   := SYS_CONTEXT('USERENV','SESSION_USER')
m_body_filename    CONSTANT VARCHAR2 (100)  := 'TY_LOGGER.PKB'
m_package_name     CONSTANT VARCHAR2(30)    := 'ty_logger.'
m_caller_class     CONSTANT VARCHAR2 (100)  := 'logging.ty_logger'
*/

-- Poor man's SDO_POINT/SDO_GEOMETRY 

--m_log_level        VARCHAR2(30)    --:= 'INFO'  -- Default Reporting LEVEL
/*
CONSTRUCTOR FUNCTION ty_logger (
								 pa_loggername       VARCHAR2 
								,pa_threadname       VARCHAR2 := SYS_CONTEXT('USERENV','SESSION_USER')
								,pa_caller_filename  VARCHAR2 := 'TY_LOGGER.PKB'
								,pa_caller_package   VARCHAR2 := 'ty_logger.'
								,pa_caller_class     VARCHAR2 := 'logging'
								,pa_log_level        VARCHAR2 := 'INFO'  -- Default Reporting LEVEL
								) RETURN SELF AS RESULT 
IS
   l_method_name   CONSTANT VARCHAR2 (30)           := 'ty_logger';
BEGIN
	loggername       := NVL(pa_loggername,'org.orgname');
	threadname       := NVL(pa_threadname,SYS_CONTEXT('USERENV','SESSION_USER'));
	caller_filename  := NVL(pa_caller_filename,'TY_LOGGER.PKB');
	caller_package   := NVL(pa_caller_package,'ty_logger.');
	caller_class     := NVL(pa_caller_class,'logging');
	
	log_level        := NVL(pa_log_level,'INFO');  -- Default Reporting LEVEL
END ty_logger;								
*/
CONSTRUCTOR FUNCTION ty_logger (
								 pa_caller_package     VARCHAR2       --:= 'ty_logger.'
								,pa_loggername         VARCHAR2 := NULL--:= 'TY_LOGGER.PKB'
								,pa_caller_filename    VARCHAR2 := NULL--:= 'TY_LOGGER.PKB'
								,pa_caller_class       VARCHAR2 := NULL--:= 'logging'
								,pa_log_level          VARCHAR2 := 'INFO'  -- Default Reporting LEVEL
								) RETURN SELF AS RESULT
IS
   l_method_name   CONSTANT VARCHAR2 (30)           := 'ty_logger';
   l_package_name VARCHAR2(30); 
BEGIN
    l_package_name := LOWER(REPLACE(caller_package,'.'));
	
	caller_package   := NVL(pa_caller_package,'ty_logger.');
	loggername       := NVL(pa_loggername,'org.orgname.'||l_package_name);
	threadname       := SYS_CONTEXT('USERENV','SESSION_USER');
	caller_filename  := NVL(pa_caller_filename,UPPER(l_package_name||'.PKB'));
	caller_class     := NVL(pa_caller_class,'org.orgname.'||l_package_name);
	
	log_level        := NVL(pa_log_level,'INFO');  -- Default Reporting LEVEL
	
	RETURN;
EXCEPTION
WHEN OTHERS THEN NULL;
		 pkg_logging.log_error (
						 pa_loggername => 'logging.ty_logger' 
						,pa_threadname => SYS_CONTEXT('USERENV','SESSION_USER')
						,pa_caller_filename => 'TY_LOGGER.PKB' 
						,pa_caller_class => 'logging.ty_logger' 
						,pa_caller_method => l_method_name 
	                     );
END ty_logger;								
								
MEMBER PROCEDURE set_log_level (pa_level VARCHAR2 )
IS
   l_method_name   CONSTANT VARCHAR2 (30)           := 'set_log_level';
BEGIN

   IF  UPPER(pa_level) IN ('ALL','TRACE','DEBUG','INFO','WARN','ERROR','FATAL','OFF')
   THEN
	log_level := UPPER(pa_level);
   ELSE
	RAISE_APPLICATION_ERROR(-20002,'ty_logger.set_log_level : Invalid log level: "' || pa_level || '"');
   END IF;
EXCEPTION WHEN OTHERS THEN
		 pkg_logging.log_error (
						 pa_loggername => 'logging.ty_logger' 
						,pa_threadname => SYS_CONTEXT('USERENV','SESSION_USER')
						,pa_caller_filename => 'TY_LOGGER.PKB' 
						,pa_caller_class => 'logging.ty_logger' 
						,pa_caller_method => l_method_name 
	                     );
	RAISE_APPLICATION_ERROR(-20001,'ty_logger.set_log_level : ' || SQLERRM, keeperrorstack=>TRUE );
END set_log_level;

MEMBER FUNCTION get_log_level RETURN  VARCHAR2
IS
   l_method_name   CONSTANT VARCHAR2 (30)           := 'get_log_level';
BEGIN
	RETURN(log_level);
EXCEPTION WHEN OTHERS THEN
		 pkg_logging.log_error (
						 pa_loggername => 'logging.ty_logger' 
						,pa_threadname => SYS_CONTEXT('USERENV','SESSION_USER')
						,pa_caller_filename => 'TY_LOGGER.PKB' 
						,pa_caller_class => 'logging.ty_logger' 
						,pa_caller_method => l_method_name 
	                     );
	RAISE_APPLICATION_ERROR(-20001,'ty_logger.get_log_level : ' || SQLERRM, keeperrorstack=>TRUE );
END get_log_level;

-- Thin wrapper on amended log_message to keep API   
MEMBER PROCEDURE log_message (pa_message VARCHAR2
                             ,pa_level_string VARCHAR2 := 'INFO'
                             ,pa_caller_method  VARCHAR2 := '?'
							 ,pa_line    VARCHAR2 := '?'
							 )
IS
   l_level_strings VARCHAR2(250) := '|OFF|FATAL|ERROR|WARN|INFO|DEBUG|ALL' ;
   l_method_name   CONSTANT VARCHAR2 (30)           := 'log_message';
BEGIN
      IF  INSTR(l_level_strings,pa_level_string) <= INSTR(l_level_strings,log_level) 	    
      THEN
		 pkg_logging.log_message(  pa_message 
		 						   	,pa_level_string 
									,pa_loggername => loggername 
									,pa_threadname =>  threadname
									,pa_caller_filename => caller_filename 
									,pa_caller_class => caller_class 
									,pa_caller_method => pa_caller_method 
									,pa_caller_line => pa_line 
		 						 );
      END IF;
EXCEPTION
WHEN OTHERS THEN NULL;
		 pkg_logging.log_error (
						 pa_loggername => 'logging.ty_logger' 
						,pa_threadname => SYS_CONTEXT('USERENV','SESSION_USER')
						,pa_caller_filename => 'TY_LOGGER.PKB' 
						,pa_caller_class => 'logging.ty_logger' 
						,pa_caller_method => l_method_name 
	                     );
END log_message;


STATIC FUNCTION locate_error (pa_skip_lines INTEGER := 2)
/*
Find the location of an error to the best resolution possible 

If the function is called from within an exception handler, the best that 
can be reported is the location of the lowest level exception handler.

This is because when an exception occurs, the call_stack immediately reflects the location of the EXCEPTION handler
rather than the location where the error occurred.

E.g examine the procedure below:

CREATE OR REPLACE PROCEDURE create_error ( pa_level NATURAL) AS
     l_method VARCHAR2(30) := 'create_method';
BEGIN
     
     pkg_logging.log_message('Test LOGGING exception logging within function at level "'|| pa_level ||'"');
     IF NVL(pa_level,1) = 1
	 THEN	 
     	  pkg_logging.log_message('Raising error at:'||
		  							DBMS_UTILITY.format_call_stack || CHR (10)
		  );
	      RAISE NO_DATA_FOUND;
	 ELSE
	 	 create_error((pa_level-1));
	 END IF;
EXCEPTION
WHEN OTHERS THEN
	 pkg_logging.log_error ;
     --RAISE_APPLICATION_ERROR(-20001,'Passed on exception from level: "' || pa_level ||'"', keeperrorstack=>TRUE); 
     RAISE_APPLICATION_ERROR(-20001,'Passed on exception from here', keeperrorstack=>TRUE); 
END create_error;

This is the result of calling this procedure 

Level
INFO
Logger
logging.plsql
Time
2006-11-24 08:22:37,385
Thread
main
Message
Raising error at:----- PL/SQL Call Stack -----
  object      line  object
  handle    number  name
3be6a4c10         8  procedure TURTONS.CREATE_ERROR
3be6a4c10        13  procedure TURTONS.CREATE_ERROR
3b2bb68b0        50  procedure TURTONS.PR_TEST_LOG_ERROR
3bf890348         4  anonymous block


The line number (8) reflects the location of the call to log_message
When the exception is raised and the call stack is examined in log_error, 
the call stack is

"
Level
DEBUG
Logger
logging.plsql
Time
2006-11-24 08:22:37,387
Thread
main
Message
CALL_STACK=<----- PL/SQL Call Stack -----
  object      line  object
  handle    number  name
3b2f8cab8       399  package body TURTONS.LOGGING
3b2f8cab8       469  package body TURTONS.LOGGING
3be6a4c10        17  procedure TURTONS.CREATE_ERROR
3be6a4c10        13  procedure TURTONS.CREATE_ERROR
3b2bb68b0        50  procedure TURTONS.PR_TEST_LOG_ERROR
3bf890348         4  anonymous block
>
"  

The first create_error line_number is 17, the location of the call to log_error in the exception handler,
rather than 11, the location of the RAISE statement.

The moral of the story is if you want to report on exceptions at a low granularity,
use a lot of BEGIN/EXCEPTION/END blocks, with calls to log_error    
 
*/
   RETURN VARCHAR2
IS
   l_method_name   CONSTANT VARCHAR2 (30)           := 'locate_error';
   call_stack    VARCHAR2 (4096)
                           DEFAULT DBMS_UTILITY.format_call_stack || CHR (10);
   error_stack    VARCHAR2 (4096)
                           DEFAULT DBMS_UTILITY.format_error_stack || CHR (10);
   n             NUMBER;
   found_stack   BOOLEAN         DEFAULT FALSE;
   line          VARCHAR2 (255);
   cnt           NUMBER          := 0;
BEGIN
   LOOP
      n := INSTR (call_stack, CHR (10));
      EXIT WHEN (cnt > pa_skip_lines OR n IS NULL OR n = 0);
      line := SUBSTR (call_stack, 1, n - 1);
      call_stack := SUBSTR (call_stack, n + 1);
      IF (NOT found_stack)
      THEN
         IF (line LIKE '%handle%number%name%') --line 3
         THEN
            found_stack := TRUE;
	        --DBMS_OUTPUT.PUT_LINE('"Found Stack"');
         END IF;
      ELSE
         cnt := cnt + 1;
      END IF;
   END LOOP;

   RETURN line;
END locate_error;

MEMBER PROCEDURE log_error (pa_caller_method  VARCHAR2 := '?')
IS
   l_method_name CONSTANT VARCHAR2(30) := 'log_error';
   l_error_location   VARCHAR2 (1024);
   l_msg      VARCHAR2 (1024) DEFAULT SQLERRM;
   l_code     NUMBER          DEFAULT SQLCODE;

   l_error_line_no      VARCHAR2(1024);
   l_error_method_type  VARCHAR2(1024);
   l_error_method       VARCHAR2(1024);
BEGIN
    l_error_line_no := ty_logger.locate_error(2);

	DECLARE
	   l_space_location pls_integer;
	BEGIN

		 l_error_line_no := TRIM(l_error_location);
		 --Point past the handle
		 l_space_location := INSTR( l_error_location,' ') ;

		 --ERROR_LINE_NO now contains the LINE_NO and the method type and name
		 l_error_line_no := TRIM(SUBSTR(l_error_line_no,l_space_location+1));
		 --Point past the LINE_NO
		 l_space_location := INSTR( l_error_line_no, ' ',+1) ;

		 l_error_method := TRIM(SUBSTR(l_error_line_no,l_space_location));

		 l_error_line_no := SUBSTR(l_error_line_no,1,l_space_location-1);

		 --Assume that
		 IF UPPER(l_error_method) = 'ANONYMOUS BLOCK'
		 THEN
				 l_error_method_type := l_error_method;
		 ELSE
		 		 l_space_location := INSTR( l_error_method, ' ') ;
				 l_error_method_type := TRIM(SUBSTR(l_error_method,1,l_space_location-1));
				 l_error_method       := TRIM(SUBSTR(l_error_method,l_space_location+1));
		 END IF;
		 
		   log_message('ERROR_METHOD_TYPE="'|| l_error_method_type||'"'
		                , 'DEBUG'
						,pa_caller_method => l_method_name
		   		      );
		 
		   log_message('ERROR_METHOD="'|| l_error_method||'"'
		                , 'DEBUG'
						,pa_caller_method => l_method_name
		   		      );
		   log_message('ERROR_LINE_NO="'|| l_error_line_no||'"'
		                , 'DEBUG'
						,pa_caller_method => l_method_name
		   		      );
	EXCEPTION
			 WHEN OTHERS THEN
			   log_message
			               ('Stack parsing error location' ||SQLERRM
							,'ERROR'
							,pa_caller_method => l_method_name
			               )
				   ;
	END;

		   pkg_logging.log_message
               (pa_message => l_msg
			    ,pa_level_string => 'ERROR'
				--,pa_timestamp => SYSTIMESTAMP
				,pa_loggername => loggername
				,pa_ndc => l_error_location
				,pa_threadname => threadname
				,pa_caller_filename => caller_filename
				,pa_caller_class => caller_class
				,pa_caller_method => l_error_method
				,pa_caller_line => l_error_line_no
               )
			   ;
EXCEPTION
WHEN OTHERS THEN NULL;
		 pkg_logging.log_error (
						 pa_loggername => 'logging.ty_logger' 
						,pa_threadname => SYS_CONTEXT('USERENV','SESSION_USER')
						,pa_caller_filename => 'TY_LOGGER.PKB' 
						,pa_caller_class => 'logging.ty_logger' 
						,pa_caller_method => l_method_name 
	                     );
END log_error;
END;
/

SHOW ERRORS 
