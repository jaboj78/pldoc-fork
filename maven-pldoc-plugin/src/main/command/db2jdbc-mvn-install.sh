
set -xv 


mvn install:install-file -Dfile=${DB2_HOME}/sqllib/java/db2jcc4.jar -Dpackaging=jar -DgroupId=com.ibm -DartifactId=db2jcc4 -Dversion=9.7.5 -Dpackage=jar -DgeneratePom=true 
mvn install:install-file -Dfile=${DB2_HOME}/sqllib/java/db2jcc_license_cu.jar -Dpackaging=jar -DgroupId=com.ibm -DartifactId=db2jcc_license_cu -Dversion=9.7.5 -Dpackage=jar -DgeneratePom=true 


export MAVEN_OPTS="-server" #Ensure that the JVM is running as server, to prevent running out of heap space 

#echo Local PL/SQL files as goal 
#mvn -f pldoc-sqlfiles-pom.xml pldoc:pldoc  

#echo Local PL/SQL files as site report plug-in 
#mvn -f pldoc-sqlfiles-pom.xml site 

echo Database PL/SQL code as goal 
mvn -s maven_db2_settings.xml -f pldoc-db2-pom.xml pldoc:pldoc  

echo Database PL/SQL code as site report plug-in 
mvn -s maven_db2_settings.xml -f pldoc-db2-pom.xml site 
