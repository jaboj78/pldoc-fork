********************************************************************************

             PLDoc utility for documenting PL/SQL code
             =========================================

Copyright (C) 2002  Albert Tumanov (altumano@users.sourceforge.net)

$Id: readme.txt 55 2011-08-29 14:15:52Z sturton $

Project directory: http://pldoc.sourceforge.net

********************************************************************************

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

********************************************************************************

This product includes software developed by the Apache Software Foundation:
  http://www.apache.org
See file xalan/license for information on redistribution.

********************************************************************************


	INSTALLATION AND USE


1) Install Java runtime version 1.2 or above, if not yet installed
   (available from http://java.sun.com).
   IMPORTANT - newer Java versions have significant performance improvements - Java 6 is recommended
2) Unpack the pldoc zip file into a new directory.
3) Run pldoc_example.bat (on Windows) or pldoc_example.sh (on UNIX) to verify installation
   and get sample output. It generates html output from the sample files
   into SampleApplicationDoc directory.
4) Edit pldoc_example.bat to try out your own files.


	CONVENTIONS FOR FORMAL COMMENTS IN THE CODE


The same rules for writing formal comments apply as for javadoc tool:
  http://java.sun.com/j2se/javadoc/writingdoccomments/index.html
Then only addition is the @headcom tag that allows a comment on package to be
placed after the "PACKAGE ... IS" keywords.
NB: the @headcom tag must be placed AFTER the main comment text.


	KNOWN PROBLEMS AND LIMITATIONS


* Currently, package specs, triggers, standalone function/procedures and types can be processed.
  ALthough package and object type bodies are parsed, little or no processing is performed within them. 
  In order to minimise the possibility of parsing problems in one module affecting another, 
  we recommend storing each module in its own input files.
* PLDoc mostly conforms to PL/SQL 9.0.1 specifications and recent changes have increased support for
  new 10G and 11G.
* PLDoc tries to read and understand informal comments like (--...) and (/*...*/)
  in those places where documentation comments are expected.
  But for the best results, use formal comments (/**...*/).
  Future versions of PLDoc are likely to ignore informal comments altogether.
* Some SQL*Plus commands and variables in the source may cause PLDoc to fail.
* Comment texts are treated as HTML, but only well-formed XHTML tags
  are allowed (must use <br/> instead of <br> etc).
* PLDoc attempts to imitate Javadoc processing for tags such as @headcom, @deprecated, @param, @return, @throws etc.
  It also attempts to process inline tags (@link, etc.) - this is still experimental.
* PLDoc attempts to generate links between objects documented in the same process: try to process all 
  files in one run. Alternatively, run PLDoc against the database directly.
* Deprecated pages not generated.
* One-line comments are ignored except before package members.


	BUILDING FROM SOURCE


During development of 0.91, PLDoc migrated from Ant to Maven: both methods should work but building 
with Maven is recommended as it automates a lot of work building, packaging and releasing PLDoc. 

        Traditional Method

Both binaries and source are included in the distribution.
You need not to rebuild the source unless you have it modified.
If you have modified only the .xsl files, no rebuild is necessary.
But you must rebuild after modifying .java or .jj files.
To rebuild, you must first install the Ant utility (http://ant.apache.org/).
Also, download and install the JavaCC utility from https://javacc.dev.java.net/.
(Do NOT add any JavaCC files to the classpath).
Then, run the make.bat (or make.sh on UNIX) from the build directory and check the output for errors.
The make.bat assumes that Ant utility is in your path
and also that you have defined environment variable JAVACC_HOME pointing
to the JavaCC directory. The environment variable ORACLE_HOME must point
to the Oracle home directory where JDBC and SQLJ jar files are located.
Either define appropriate variables or make changes in the make.bat file.

        Maven Method
 
Download and install Maven if you do not already have it installed (see http://maven.apache.org/download.html)

After Maven installation and downloading the source use Maven to build the project (mvn install)

    mvn -U clean package resources:testResources

    IMPORTANT: building PLDoc now takes significantly longer than building version 0.9.0; 
               build typically takes 30 minutes or so.


	GETTING THE LATEST SOURCE


During development of 0.9.1, PLDoc migrated to Subversion (SVN): the CVS repository is no longer updated.

To get the latest source, you must have an SVN client installed.
The basic command for getting the very latest source is:

svn co https://pldoc.svn.sourceforge.net/svnroot/pldoc/pldoc/trunk pldoc

If you need source from a specific release (say, "pldoc-X.Y.Z"), use:

svn co https://pldoc.svn.sourceforge.net/svnroot/pldoc/pldoc/tags/pldoc-X.Y.Z pldoc-X.Y.Z 

See also SourceForge SVN usage instructions:
http://sourceforge.net/svn/?group_id=38875

there are 2 maven projects:
    pldoc (located in the trunk folder)
    maven-pldoc-plugin (located in the maven-pldoc-plugin folder)

********************************************************************************
