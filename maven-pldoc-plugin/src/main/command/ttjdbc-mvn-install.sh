
set -xv 

# Ensure that the PLDOc utility is compiled, packaged and installed into the local repository 
#( cd ../pldoc/trunk  ; mvn package install ) 
#mvn install:install-file -Dfile=pldoc/target/pldoc-1.1.5-SNAPSHOT-jar-with-dependencies.jar -Dpackaging=jar -DgroupId=net.sourceforge.pldoc -DartifactId=pldoc -Dversion=1.1.5-SNAPSHOT -Dpackage=jar -DgeneratePom=true 
# Ensure that the PLDOc maven plugin is compiled, packaged and installed into the local repository 
#mvn package install 
#mvn install:install-file -Dfile=pldoc/target/.jar -Dpackaging=jar -DgroupId=net.sourceforge.pldoc -DartifactId=maven-pldoc-plugin -Dversion=2.15-SNAPSHOT -Dpackage=jar -DgeneratePom=true 

#Install the TimesTen JDBC JAR file in the local repository, so that the Oracle JDBC jar file(s) are available as a dependency  
#mvn install:install-file -Dfile=${ORACLE_HOME}/orai18n.jar -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=10.2.0.3 -Dpackage=jar 

mvn install:install-file -Dfile=${TT_HOME}/lib/ttjdbc6.jar -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ttjdbc6 -Dversion=11.2.2 -Dpackage=jar -DgeneratePom=true 

export MAVEN_OPTS="-server" #Ensure that the JVM is running as server, to prevent running out of heap space 

#echo Local PL/SQL files as goal 
#mvn -f pldoc-sqlfiles-pom.xml pldoc:pldoc  

#echo Local PL/SQL files as site report plug-in 
#mvn -f pldoc-sqlfiles-pom.xml site 

echo Database PL/SQL code as goal 
mvn -s maven_timesten_settings.xml -f pldoc-timesten-pom.xml pldoc:pldoc  

echo Database PL/SQL code as site report plug-in 
mvn -s maven_timesten_settings.xml -f pldoc-timesten-pom.xml site 
