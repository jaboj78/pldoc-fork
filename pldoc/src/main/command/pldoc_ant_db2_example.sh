
PLDOC_HOME=$( cd $(dirname "$0" ) && pwd )
if [ "${PLDOC_HOME}" == "" ]
then  
    echo "ERROR: Environment variable PLDOC_HOME not set." 1>&2 && exit 1 
fi

#The endorsed directories mechanism is necessary because of the exslt:node-set calls in unit.xsl 
#In production, reference the standalone XALAN and XERCES jar files in java.endorsed.dirs, 
#use the standalone PLDoc jar and DB2 JDBC as normal

INITIAL_ANT_OPTS="$ANT_OPTS"
export ANT_OPTS="-server -Djava.endorsed.dirs=${PLDOC_HOME}/target -Dpldoc.home='${PLDOC_HOME}' ${INITIAL_ANT_OPTS}" #Force server JVM 

ant -f ant_example.xml

# rem Include DB2 jars in the classpath 
if [ "${DB2_HOME}" =  "" ]
then
	echo "INFO: Environment variable DB2_HOME not set. Skipping database example" 1>&2 
else
	#export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF-8"
	#export JAVA_OPTS=" -Dfile.encoding=UTF-8"
	export NLS_LANG=.UTF8
	if [ -d "${DB2_HOME}"/sqllib/java ]
	then
	  JDBC_HOME="${DB2_HOME}"/sqllib/java 
	elif [ -d "${DB2_HOME}" ]
	then
	  JDBC_HOME="${DB2_HOME}" 
	fi 
	if [ "${JDBC_HOME}" =  "" ]
	then
		echo "WARN: Cannot locate JDBC directory. Ensure that JDBC_HOME is specified in ant_enterprise_example.properties and in java.endorsed.dirs " 1>&2 
		ant -f ant_db2_example.xml -propertyfile ant_db2_example.properties
	else
		#Run against all DB2 Enterprise schemas
		#ant -DJDBC_HOME=${JDBC_HOME} -f ant_enterprise_example.xml
		#It seems that because the PLDoc class is loaded from endorsed dirs, then the JDBC classes loaded in it must also be loaded from endorsed dirs   
 		export ANT_OPTS="-server -Djava.endorsed.dirs=${PLDOC_HOME}/target:${JDBC_HOME} -Djava.library.path=/home/db2inst1/sqllib/lib32 ${INITIAL_ANT_OPTS}"  
		ant -DJDBC_HOME="${JDBC_HOME}" -f ant_db2_example.xml -propertyfile ant_db2_example.properties
	fi
fi


