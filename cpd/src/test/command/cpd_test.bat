REM $Id$
setlocal

call ..\cpd.bat -showSkippedPackages -outputfile TestDoc1.txt testinput/*.sql
call ..\cpd.bat -showSkippedPackages -outputfile TestDoc2.txt -inputencoding utf-8 testinput/chinese.pks
call ..\cpd.bat -showSkippedPackages -outputfile TestDoc3.txt testinput/packages/*.* testinput/objecttypes/*.* testinput/datetime-source/*.* testinput/schemalevel/*.*  testinput/triggers/*.* testinput/xe-problems/*.* testinput/11g-source/*.* testinput/bugs/*.sql 

@REM rem Include Oracle jars in the classpath 
if "%ORACLE_HOME%" == "" ( echo INFO: Environment variable ORACLE_HOME not set. Skipping database tests 1>&2 && goto end )

@REM run against all Oracle XE schemas (Oracle XE 11g Beta) - including package and type bodies  
echo INFO: Environment variable ORACLE_HOME is set. Attempting database tests ... 1>&2 
call ..\cpd.bat -showSkippedPackages -outputfile TestDocXE-ALL.txt -url jdbc:oracle:thin:@//192.168.100.158:1521/XE -user system -password oracle -sql "APEX_040000.%%%%,APPQOSSYS.%%%%,CTXSYS.%%%%,DBSNMP.%%%%,FLOWS_FILES.%%%%,HR.%%%%,MDSYS.%%%%,ORACLE_OCM.%%%%,OUTLN.%%%%,PUBLIC.%%%%,SYSTEM.%%%%,TESTUSER.%%%%,XDB.%%%%,SYS.%%%%"  -types "\"PROCEDURE,FUNCTION,TRIGGER,PACKAGE,TYPE,PACKAGE BODY,TYPE BODY\""
set JAVA_OPTS=" -Dfile.encoding=UTF-8"
set NLS_LANG=.UTF8

REM Run against all Oracle Enterprise schemas
call ..\cpd.bat -showSkippedPackages -format xml -savesourcecode -outputfile TestDoc11GR2-ENTERPRISE-ALL.txt -url jdbc:oracle:thin:@//192.168.100.22:1521/orcl -user system -password oracle -sql "ANONYMOUS.%%%%,APEX_040000.%%%%,APEX_PUBLIC_USER.%%%%,APPQOSSYS.%%%%,BI.%%%%,CACHEADM.%%%%,CTXSYS.%%%%,DBSNMP.%%%%,DEMO.%%%%,DIP.%%%%,EXFSYS.%%%%,FLOWS_FILES.%%%%,HR.%%%%,HR1.%%%%,HR_TRIG.%%%%,IX.%%%%,MDDATA.%%%%,MDSYS.%%%%,MGMT_VIEW.%%%%,OBE.%%%%,OE.%%%%,OE1.%%%%,OLAPSYS.%%%%,ORACLE_OCM.%%%%,ORDDATA.%%%%,ORDPLUGINS.%%%%,ORDSYS.%%%%,OUTLN.%%%%,OWBSYS.%%%%,OWBSYS_AUDIT.%%%%,PHPDEMO.%%%%,PLS.%%%%,PM.%%%%,SCOTT.%%%%,SH%%%%,SI_INFORMTN_SCHEMA.%%%%,SPATIAL_CSW_ADMIN_USR.%%%%,SPATIAL_WFS_ADMIN_USR.%%%%,SYS.%%%%,SYSMAN.%%%%,SYSTEM.%%%%,TIMESTEN.%%%%,TTHR.%%%%,WMSYS.%%%%,XDB.%%%%,XDBMETADATA.%%%%,XDBPM.%%%%,XFILES.%%%%,XS$NULL.%%%%"  -types "\"PROCEDURE,FUNCTION,TRIGGER,PACKAGE,TYPE,PACKAGE BODY,TYPE BODY\""

:end
PAUSE
endlocal

