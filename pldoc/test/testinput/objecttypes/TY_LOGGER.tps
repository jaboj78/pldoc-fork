SET DEFINE OFF

CREATE OR REPLACE
TYPE ty_logger AS 
OBJECT (
/**
<P>
  Create logging context to minimize code requires to use {@link PKG_LOGGING}.
</P>
<P>Essentially stores the invariant part of the current environment : loggername, threadname, caller's filename, package and class etc.
</P>
<P> Follow these steps to use this TYPE within PL/SQL:
<OL>
<LI>Declare and create the logger:
<PRE>
<CODE>
  CREATE OR REPLACE PACKACE BODY  example_package
  ..
  package_logger TY_LOGGER ;
  ...
  ...
  BEGIN -- Package Initialisation
    package_logger := TY_LOGGER(
				 pa_loggername       => 'org.orgname.example_package'
				,pa_caller_filename  => 'EXAMPLE_PACKAGE.PKB'
				,pa_caller_package   => 'example_package.'
				,pa_caller_class     => 'org.orgname.example_package'
				,pa_log_level        => 'INFO'  -- Default Reporting LEVEL
				);
  -- Handle Initialisation Errors using direct calls to PKG_LOGGING
  ...
  END example_package;
</CODE>
</PRE>
</OL>
</P>
--@headcom
*/
 -- Arbitrary Name of the logger: 
 loggername       VARCHAR2(100)   --:= 'org.orgname'
 -- Name to identify this instance of the process: use $PPID (Parent Process ID)  under Unix 
,threadname       VARCHAR2(100)   --:= SYS_CONTEXT('USERENV','SESSION_USER')
 -- Source code containing the code which creates this logger
,caller_filename  VARCHAR2 (100)  --:= 'TY_LOGGER.PKB'
 -- Package name in PL/SQL: use the High level process name (e.g. LM_EXPORT) when logging a Unix Process
,caller_package   VARCHAR2(30)    --:= 'ty_logger.'
 -- Class name in Java, Package name (prepended with org.orgname) in PL/SQL
,caller_class     VARCHAR2 (100)  --:= 'logging'

--These should be private
,log_level        VARCHAR2(30)    --:= 'INFO'  -- Default Reporting LEVEL


/*
,CONSTRUCTOR FUNCTION ty_logger (
								 pa_loggername       VARCHAR2 
								,pa_threadname       VARCHAR2 := SYS_CONTEXT('USERENV','SESSION_USER')
								,pa_caller_filename  VARCHAR2 := 'TY_LOGGER.PKB'
								,pa_caller_package   VARCHAR2 := 'ty_logger.'
								,pa_caller_class     VARCHAR2 := 'logging'
								,pa_log_level        VARCHAR2 := 'INFO'  -- Default Reporting LEVEL
								) RETURN SELF AS RESULT
*/
,
/**
Create the logger object, storing the context of the logger.
<P>
--@param pa_caller_package     package name  - defaults to 'ty_logger.'
--@param pa_loggername         Arbitrary name to stamp log messages with: by convention it is the "classname" 
--@param pa_caller_filename    The name of the script containing the call to the constructor, e.g. import_xml.sql
--@param pa_caller_class       The name of the "class" containing the call to the constructor, e.g. logging'
--@param pa_log_level          The level  (see {@link PKG_LOGGING.SET_LOG_LEVEL} at which logged messages should be initially written to the logging tables.
                               The level may then be modified using {@link SET_LOG_LEVEL}
<P>
**/
CONSTRUCTOR FUNCTION ty_logger (
								 pa_caller_package     VARCHAR2       --:= 'ty_logger.'
								,pa_loggername         VARCHAR2 := NULL--:= 'TY_LOGGER.PKB'
								,pa_caller_filename    VARCHAR2 := NULL--:= 'TY_LOGGER.PKB'
								,pa_caller_class       VARCHAR2 := NULL--:= 'logging'
								,pa_log_level          VARCHAR2 := 'INFO'  -- Default Reporting LEVEL
								) RETURN SELF AS RESULT
,
/**
Alter the level at which logged messages will be written to the database 
<P>
--@param pa_log_level          The level  (see {@link PKG_LOGGING.LOG_LEVEL} at which logged messages should be subsequently written to the logging tables.
<P>
**/
MEMBER PROCEDURE set_log_level (pa_level VARCHAR2)
,
/**
Get the level at which logged messages are currently written to the database 
<P>
--@return The level  (see {@link PKG_LOGGING.LOG_LEVEL} at which logged messages are currently written to the logging tables.
<P>
**/
MEMBER FUNCTION get_log_level RETURN  VARCHAR2 
,
/**
Log a message, writing the message (including context information) to the logging tables <B>if</B> the message level is equal or greater than the current level for this logger object. 
<P>
--@param pa_message               Message text
--@param pa_level_string          Message level:  if this object's level allows, this message will be written to the logging tables.
--@param pa_caller_method         PL/SQL function in which this method was invoked: it is up to the programmer to set this information correctly as PL/SQL cannot always infer this information.
--@param pa_line                  line number in which this method was invoked: it is up to the programmer to set this information correctly.
<P>
**/
MEMBER PROCEDURE log_message (pa_message VARCHAR2
                              ,pa_level_string VARCHAR2 := 'INFO'
                              ,pa_caller_method  VARCHAR2 := '?'
							  ,pa_line    VARCHAR2 := '?'
							  )
,
/**
Log an error, writing the text from the PL/SQL Error stack( with message level 'ERROR' and including context information) to the logging tables <B>if</B> the message level ('ERROR') is equal or greater than the current level for this logger object. 
<P>The error location (PL/SQL function and line number are derived from the call_stack using {@link locate_error} if possible). However, this first location recorded in the cal stack when an error occurs is the first EXCEPTION handler.
Fine granularity of error location can only be had by adding more exception handlers.
</p>
<P>
--@param pa_caller_method         PL/SQL function in which this error was caught: it is up to the programmer to set this information correctly as PL/SQL cannot always infer this information.
<P>
**/
MEMBER PROCEDURE log_error (pa_caller_method  VARCHAR2 := '?'
							)
,
/**
Get the level at which logged messages are currently written to the database 
<P>
--@param pa_skip_lines   The number of stack frames to skip before looking for errors, locate_error will add 1 stack frame and usually the calling function will add another. This is why the default value is 2.
--@return The identified error location -   'package name.function name line_number' for  or 'ANONYMOUS BLOCK line_number' for anonymous PL/SQL.
<P>
**/
STATIC FUNCTION locate_error (pa_skip_lines INTEGER := 2) RETURN VARCHAR2							
);
/

SHOW ERRORS 
