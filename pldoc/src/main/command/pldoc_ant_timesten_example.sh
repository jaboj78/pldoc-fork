
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

# rem Include TimesTen jars in the classpath 
if [ "${TT_HOME}" =  "" ]
then
	echo "INFO: Environment variable TT_HOME not set. Skipping database example" 1>&2 
else
	#export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF-8"
	#export JAVA_OPTS=" -Dfile.encoding=UTF-8"
	export NLS_LANG=.UTF8
        #export LD_LIBRARY_PATH="$TT_HOME/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
        #SRT export LD_LIBRARY_PATH="$TT_HOME/lib"

	if [ -d "${TT_HOME}"/lib ]
	then
	  JDBC_HOME="${TT_HOME}"/lib 
	elif [ -d "${TT_HOME}" ]
	then
	  JDBC_HOME="${TT_HOME}" 
	fi 
	if [ "${JDBC_HOME}" =  "" ]
	then
		echo "WARN: Cannot locate JDBC directory. Ensure that JDBC_HOME is specified in ant_enterprise_example.properties and in java.endorsed.dirs " 1>&2 
		ant -f ant_timesten_example.xml -propertyfile ant_timesten_example.properties
	else
		#Run against all DB2 Enterprise schemas
		#ant -DJDBC_HOME=${JDBC_HOME} -f ant_enterprise_example.xml
		#It seems that because the PLDoc class is loaded from endorsed dirs, then the JDBC classes loaded in it must also be loaded from endorsed dirs   
                #Requires 32-bit Java as TimesTEn client libraries are 32-bit only
 		export ANT_OPTS="-server -Djava.endorsed.dirs=${PLDOC_HOME}/target:${JDBC_HOME} -Dcom.ibm.oti.vm.bootstrap.library.path=${TT_HOME}/lib -Djava.library.path=${TT_HOME}/lib ${INITIAL_ANT_OPTS}"  
                echo LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
		ant -DJDBC_HOME="${JDBC_HOME}" -f ant_timesten_example.xml -propertyfile ant_timesten_example.properties
	fi
fi


