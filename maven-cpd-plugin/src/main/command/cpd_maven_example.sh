
export MAVEN_OPTS="-server" #Force server JVM 
#Run against Example SQL files 
#As goal 
mvn -f cpd-sqlfiles-pom.xml pldoccpd:cpd  

# As site report plug-in 
mvn -f cpd-sqlfiles-pom.xml site 

# rem Include Oracle jars in the classpath 
if [ "${ORACLE_HOME}" =  "" ]
then
	echo "INFO: Environment variable ORACLE_HOME not set. Skipping database example" 1>&2 
else
	#set -xv
	#export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF-8"
	#export JAVA_OPTS=" -Dfile.encoding=UTF-8"
	export NLS_LANG=.UTF8
	if [ -d ${ORACLE_HOME}/jdbc/lib ]
	then
	  export JDBC_HOME=${ORACLE_HOME}/jdbc/lib 
	elif [ -d ${ORACLE_HOME} ]
	then
	  export JDBC_HOME=${ORACLE_HOME} 
	fi 
	if [ "${JDBC_HOME}" =  "" ]
	then
		echo "WARN: Cannot locate JDBC directory. Ensure that JDBC files hav been installed into local Maven Repository" 1>&2 
	fi

	#Run against all Oracle Enterprise schemas

	#As goal 
	mvn -s maven_enterprise_settings.xml -f cpd-enterprise-pom.xml pldoccpd:cpd  

	# As site report plug-in 
	mvn -s maven_enterprise_settings.xml -f cpd-enterprise-pom.xml site 
fi


