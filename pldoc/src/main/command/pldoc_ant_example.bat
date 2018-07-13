setlocal 
@set echo off 
set PLDOC_HOME=%~dp0
if "%PLDOC_HOME%" == "" ( echo ERROR: Environment variable PLDOC_HOME not set. 1>&2 && exit /b 1 )

@REM The endorsed directories mechanism is necessary because of the exslt:node-set calls in unit.xsl 
@REM In production, reference the standalone XALAN and XERCES jar files in java.endorsed.dirs, 
@REM use the standalone PLDoc jar and Oracle JDBC as normal

set INITIAL_ANT_OPTS=%ANT_OPTS%
set ANT_OPTS=-server -Djava.endorsed.dirs=%PLDOC_HOME%/target -Dpldoc.home=%PLDOC_HOME% %INITIAL_ANT_OPTS%
call ant -f ant_example.xml

@REM rem Include Oracle jars in the classpath 
if "%ORACLE_HOME%" == "" ( echo INFO: Environment variable ORACLE_HOME not set. Skipping database example 1>&2 && goto end )

        @REM Include Oracle jars in the classpath 
	@REM Run against all Oracle Enterprise schemas (Oracle 11g) - including package and type bodies  
	echo "INFO: Environment variable ORACLE_HOME is set. Attempting database example ..." 1>&2 
        if EXIST %ORACLE_HOME%\JDBC\LIB set JDBC_HOME=%ORACLE_HOME%\JDBC\LIB
        if EXIST %ORACLE_HOME% set JDBC_HOME=%ORACLE_HOME%
	set NLS_LANG=.UTF8
	@REM Run against all Oracle Enterprise schemas
	@REM call ant -DJDBC_HOME=%JDBC_HOME% -f ant_enterprise_example.xml
	@REM It seems that because the PLDoc class is loaded from endorsed dirs, then the JDBC classes loaded in it must also be loaded from endorsed dirs   
	if "%JDBC_HOME%" == "" ( echo "WARN: Cannot locate JDBC directory. Ensure that JDBC_HOME is specified in ant_enterprise_example.properties and java.endorsed.dirs" 1>&2 && call ant -f ant_enterprise_example.xml ant -propertyfile ant_enterprise_example.properties) else ( set ANT_OPTS=-server -Djava.endorsed.dirs=%PLDOC_HOME%/target;%JDBC_HOME% %INITIAL_ANT_OPTS% && call ant -DJDBC_HOME=%JDBC_HOME% -f ant_enterprise_example.xml -propertyfile ant_enterprise_example.properties)
	

:end
@PAUSE
endlocal
