
set -xv 

# Ensure that the PLDOc utility is compiled, packaged and installed into the local repository 
( cd ../pldoc/trunk  ; mvn package install ) 
# Ensure that the PLDOc maven plugin is compiled, packaged and installed into the local repository 
mvn package install 

#Install the Oracle JDBC JAR file in the local repository, so that the Oracle JDBC jar file(s) are available as a dependency  
#mvn install:install-file -Dfile=${ORACLE_HOME}/orai18n.jar -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.3 -Dpackage=jar 
mvn install:install-file -Dfile=${ORACLE_HOME}/ojdbc14.jar -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.3 -Dpackage=jar -DgeneratePom=true 

export MAVEN_OPTS="-server" #Ensure that the JVM is running as server, to prevent running out of heap space 

echo Local PL/SQL files as goal 
mvn -f cpd-sqlfiles-pom.xml pldoccpd:cpd  

echo Local PL/SQL files as site report plug-in 
mvn -f cpd-sqlfiles-pom.xml site 

echo Database PL/SQL code as goal 
mvn -f cpd-enterprise-pom.xml pldoccpd:cpd  

echo Database PL/SQL code as site report plug-in 
mvn -f cpd-enterprise-pom.xml site 
