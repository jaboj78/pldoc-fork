#!/bin/sh
#
# pldoc.sh - Unix start script
# $Id$
#
# Normally, editing this script should not be required.
#
# The installation idea is to unpack the PLDoc tar/zip in lets say:
# /usr/local/pldoc
# and then make a symbolic link to pldoc.sh in /usr/local/bin, ex.
# $ cd /usr/local/bin ; ln -s /usr/local/pldoc/pldoc.sh pldoc

PRG=$0

#
# Resolve the location of the pldoc installation
# resolve symlinks (idea taken from Netbean's runide.sh)
#
while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '^.*-> \(.*\)$' 2>/dev/null`
    if expr "$link" : '^/' 2> /dev/null >/dev/null; then
	PRG="$link"
    else
	PRG="`dirname "$PRG"`/$link"
    fi
done

pldir=`dirname "$PRG"`

# absolutize pldir
oldpwd=`pwd` ; cd "${pldir}"; pldir=`pwd`; cd "${oldpwd}"; unset oldpwd

# Set bootclasspath.
# NB: this is needed to make JDK1.4 use our Xerces version instead of internal parser
#bcp="${pldir}/xalan/bin/xalan.jar:${pldir}/xalan/bin/xml-apis.jar:${pldir}/xalan/bin/xercesImpl.jar"
#
# Set classpath
# NB: classpath must contain the pldoc directory to be able to locate .xsl files
cp="${pldir}:${pldir}/target/${project.build.finalName}-jar-with-dependencies.jar"

# Save arguments
args=$*

# Are the Oracle jars needed?
while test -n "$1"
do
  if [ "$1" = "-url" ]
  then
    if [ -z "$ORACLE_HOME" ]
    then
      echo ERROR: Environment variable ORACLE_HOME not set. 1>&2
      exit 1
    else
      #Normal ORACLE_HOME 
      cp="${cp}:$ORACLE_HOME/jdbc/lib/ojdbc6.jar:$ORACLE_HOME/jdbc/lib/ojdbc5.jar:$ORACLE_HOME/jdbc/lib/ojdbc14.jar:$ORACLE_HOME/jdbc/lib/classes12.jar"
      #InstantClienr ORACLE_HOME 
      cp="${cp}:$ORACLE_HOME/ojdbc6.jar:$ORACLE_HOME/ojdbc5.jar:$ORACLE_HOME/ojdbc14.jar:$ORACLE_HOME/classes12.jar"
    fi
    break
  fi
  shift
done

#
# Call PLDoc
#java -jar ${pldir}/target/${project.build.finalName}-jar-with-dependencies.jar "$@"
java -server -cp "$cp" net.sourceforge.pldoc.cpd.CPD $args
