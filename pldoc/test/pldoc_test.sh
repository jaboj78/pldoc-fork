# $Id$
../pldoc.sh -doctitle \"TEST\" -overview testinput/overview1.html -d TestDoc testinput/*.sql 
../pldoc.sh -showSkippedPackages -doctitle \"TEST\" -overview testinput/overview1.html -d TestDoc2 -inputencoding utf-8 testinput/chinese.pks
../pldoc.sh -showSkippedPackages -doctitle \"TEST\" -overview testinput/overview1.html -d TestDoc3 testinput/packages/*.* testinput/objecttypes/*.* testinput/datetime-source/*.* testinput/schemalevel/*.*  testinput/triggers/*.* testinput/xe-problems/*.* testinput/11g-source/*.* testinput/bugs/*.sql 


# rem Include Oracle jars in the classpath 
if [ "${ORACLE_HOME}" =  "" ]
then
	echo "INFO: Environment variable ORACLE_HOME not set. Skipping database tests" 1>&2 
else
	# Run against all Oracle XE schemas (Oracle XE 11g Beta) - including package and type bodies  
	echo "INFO: Environment variable ORACLE_HOME is set. Attempting database tests ..." 1>&2 
	../pldoc.sh -plscope -showSkippedPackages -d TestDocXE-ALL -url jdbc:oracle:thin:@//192.168.100.158:1521/XE -user system -password oracle -sql "APEX_040000.%%%%,APPQOSSYS.%%%%,CTXSYS.%%%%,DBSNMP.%%%%,FLOWS_FILES.%%%%,HR.%%%%,MDSYS.%%%%,ORACLE_OCM.%%%%,OUTLN.%%%%,PUBLIC.%%%%,SYSTEM.%%%%,TESTUSER.%%%%,XDB.%%%%,SYS.%%%%"  -types "\"PROCEDURE,FUNCTION,TRIGGER,PACKAGE,TYPE,PACKAGE BODY,TYPE BODY,JAVA SOURCE\""

	export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF-8"
	export JAVA_OPTS=" -Dfile.encoding=UTF-8"
	export NLS_LANG=.UTF8
	#Run against all Oracle Enterprise schemas
	../pldoc.sh -plscope -showSkippedPackages -d TestDoc11GR2-ENTERPRISE-ALL -url jdbc:oracle:thin:@//192.168.100.22:1521/orcl -user system -password oracle -sql "ANONYMOUS.%%%%,APEX_040000.%%%%,APEX_PUBLIC_USER.%%%%,APPQOSSYS.%%%%,BI.%%%%,CACHEADM.%%%%,CTXSYS.%%%%,DBSNMP.%%%%,DEMO.%%%%,DIP.%%%%,EXFSYS.%%%%,FLOWS_FILES.%%%%,HR.%%%%,HR1.%%%%,HR_TRIG.%%%%,IX.%%%%,MDDATA.%%%%,MDSYS.%%%%,MGMT_VIEW.%%%%,OBE.%%%%,OE.%%%%,OE1.%%%%,OLAPSYS.%%%%,ORACLE_OCM.%%%%,ORDDATA.%%%%,ORDPLUGINS.%%%%,ORDSYS.%%%%,OUTLN.%%%%,OWBSYS.%%%%,OWBSYS_AUDIT.%%%%,PHPDEMO.%%%%,PLS.%%%%,PM.%%%%,SCOTT.%%%%,SH%%%%,SI_INFORMTN_SCHEMA.%%%%,SPATIAL_CSW_ADMIN_USR.%%%%,SPATIAL_WFS_ADMIN_USR.%%%%,SYS.%%%%,SYSMAN.%%%%,SYSTEM.%%%%,TIMESTEN.%%%%,TTHR.%%%%,WMSYS.%%%%,XDB.%%%%,XDBMETADATA.%%%%,XDBPM.%%%%,XFILES.%%%%,XS$NULL.%%%%"  -types "\"PROCEDURE,FUNCTION,TRIGGER,PACKAGE,TYPE,PACKAGE BODY,TYPE BODY,JAVA SOURCE\""
fi


