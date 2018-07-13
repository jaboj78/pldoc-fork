<?xml version="1.0" encoding="UTF-8"?>

<!-- Copyright (C) 2002 Albert Tumanov

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

-->
<!--$Header: /cvsroot/pldoc/sources/src/resources/allschemas.xsl,v 1.1 2005/01/14 10:16:27 t_schaedler Exp $-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
  xmlns:java="http://xml.apache.org/xalan/java"
  extension-element-prefixes="redirect str java"
  exclude-result-prefixes="java"
  >

  <xsl:output method="html" indent="yes"/>
  
  <xsl:include href="common.xsl" />
	
  <xsl:param name="targetFolder"/>

  <xsl:key name="schemaInit" match="*[@SCHEMA]" use="@SCHEMA"/>
	
  	
	
	<xsl:template match="/">
		<xsl:for-each select="APPLICATION">
	    <HTML>
	    <HEAD>
	    <TITLE><xsl:value-of select="@NAME" /></TITLE>
	    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style"/>
	    </HEAD>
	    <BODY BGCOLOR="white">
	
	    <!-- generate a link to the all-packages list -->
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
		    <TD><FONT size="+1" CLASS="FrameItemFont">
		    <A HREF="allpackages.html" target="listFrame">All Packages, Object Types and Collections</A></FONT></TD>
	    </TR>
	    </TABLE>
	    
		<BR />
		
		<!-- add the title -->
		<xsl:if test="@SCHEMA">
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
		    <TD><FONT size="+1" CLASS="FrameTitleFont">
		    <B>Schemas</B></FONT></TD>
	    </TR>
	    </TABLE>
		</xsl:if>
		
	    <!-- List all distinct schemas using Muenchian method -->
		<xsl:for-each select="//*[count(. | key('schemaInit', @SCHEMA)[1]) = 1 and @SCHEMA != '' and @SCHEMA != 'SYS' ]">
		  <!-- generate the linked pages with only-schema-packages -->
		  <xsl:call-template name="schemaonly">
		    <xsl:with-param name="theschema" select="@SCHEMA"/>
		  </xsl:call-template>
	     
		</xsl:for-each>
	
	    <P></P>
	    </BODY>
	    </HTML>
	  </xsl:for-each>
  </xsl:template>

  <!-- this template processes all packages of the specified schema -->
  <xsl:template name="schemaonly">
     <xsl:param name="theschema"/>
      <xsl:variable name="thisSchema"><xsl:value-of select="translate($theschema, $namesFromCase, $namesToCase )"/></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $theschema  ))"/></xsl:variable>
     
	  <!-- generate a link to the only-schema-packages list -->
      <FONT CLASS="FrameItemFont"><A HREF="{$hrefSchema}.html" TARGET="listFrame">
        <xsl:value-of select="$thisSchema"/>
      </A></FONT><BR></BR>
     
     <!-- generate the file: package list of this schema -->
     <redirect:write file="{concat($targetFolder, $thisSchema)}.html">
	    <HTML>
	    <HEAD>
	    <TITLE><xsl:value-of select="concat( $thisSchema ,' Schema')" /></TITLE>
	    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style"/>
	    </HEAD>
	    <BODY BGCOLOR="white">
	
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
		    <TD><FONT size="+1" CLASS="FrameTitleFont">
		    <B><A HREF="{$hrefSchema}-summary.html" TARGET="packageFrame">
		    	<xsl:value-of select="$thisSchema" />
		    </A></B>
		    </FONT></TD>
	    </TR>
	    </TABLE>
	
	    <xsl:if test="//OBJECT_TYPE[@SCHEMA=$theschema and COLLECTIONTYPE ] ">
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Object Collections</FONT>
	    <BR />
	    <BR />
	
	    <xsl:for-each select="//OBJECT_TYPE[@SCHEMA=$theschema and COLLECTIONTYPE ]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema, '/', $hrefObject )}.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject"/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    <xsl:if test="//OBJECT_TYPE[@SCHEMA=$theschema and not(COLLECTIONTYPE) ] ">
	    <BR />
	    <BR />
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Object Types</FONT>
	    <BR />
	    <BR />
	
	    <xsl:for-each select="//OBJECT_TYPE[@SCHEMA=$theschema and not(COLLECTIONTYPE) ]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat($hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject"/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    <!-- Defer treating triggers as top level objects 
	    <xsl:if test="//TRIGGER[@SCHEMA=$theschema ] ">
	    <BR />
	    <BR />
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Triggers</FONT>
	    <BR />
	    <BR />
	
	    <xsl:for-each select="//TRIGGER[@SCHEMA=$theschema]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <FONT CLASS="FrameItemFont"><A HREF="{translate(@NAME, $namesFromCase, $namesToCase)}.html" TARGET="packageFrame">
	        <xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	    -->
	
	    <xsl:if test="//PACKAGE[@SCHEMA=$theschema]">
	    <BR />
	    <BR />
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Packages</FONT>
	    <BR />
	    <BR />
	
	    <xsl:for-each select="//PACKAGE[@SCHEMA=$theschema]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject ) }.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject"/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    <xsl:if test="//JAVA[ @SCHEMA=$theschema and @TYPE='SOURCE'] ">
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Java</FONT>
	    <BR />
	    <BR />
	
	    <xsl:for-each select="//JAVA[ @SCHEMA=$theschema and @TYPE='SOURCE' ]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject"/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    <xsl:if test="//*[ @SCHEMA=$theschema and ( local-name() = 'PACKAGE_BODY' or local-name()='OBJECT_BODY' ) ]">
	    <BR />
	    <BR />
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Bodies</FONT>
	    <BR />
	    <BR />
	
	    <xsl:for-each select="//*[ @SCHEMA=$theschema and ( local-name() = 'PACKAGE_BODY' or local-name()='OBJECT_BODY' ) ]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/_', $hrefObject )}_body.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject "/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    <xsl:if test="//TABLE[@SCHEMA=$theschema]">
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Tables</FONT>
	    <BR></BR>
	
	    <xsl:for-each select="//TABLE[@SCHEMA=$theschema]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject "/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    <xsl:if test="//VIEW[@SCHEMA=$theschema]">
	    <TABLE BORDER="0" WIDTH="100%">
	    <TR>
	    <TD><FONT size="+1" CLASS="FrameHeadingFont">
	    Views</FONT>
	    <BR></BR>
	
	    <xsl:for-each select="//VIEW[@SCHEMA=$theschema]">
              <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
	      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
	      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
	      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
	      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
	        <xsl:value-of select="$thisObject"/>
	      </A></FONT><BR></BR>
	    </xsl:for-each>
	
	    </TD>
	    </TR>
	    </TABLE>
	    </xsl:if>
	
	    </BODY>
	    </HTML>
    </redirect:write>
    
 	<!-- generate the file: package summary of this schema -->
    <redirect:write file="{concat($targetFolder, translate($theschema, $namesFromCase, $namesToCase))}-summary.html">
	    
      	    <HTML>
	    <HEAD>
	    <TITLE><xsl:value-of select="@NAME" />: Overview</TITLE>
	    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style" />
	    </HEAD>
	
	    <BODY BGCOLOR="white">
	    <!-- **************************** HEADER ******************************* -->
	    <xsl:call-template name="NavigationBar"/>
	
	    <CENTER><H2>Schema <xsl:value-of select="$theschema" /></H2></CENTER>
	    <xsl:value-of select="OVERVIEW" disable-output-escaping="yes" />
	    <P/><P/>
	
	    <!-- **************************** Object Collections ******************************* -->
		<xsl:if test="//OBJECT_TYPE[@SCHEMA=$theschema and COLLECTIONTYPE]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Object Collections</FONT></TD></TR>
		
		    <xsl:for-each select="//OBJECT_TYPE[@SCHEMA=$theschema]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject "/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
	
	    <!-- **************************** Object Types ******************************* -->
		<xsl:if test="//OBJECT_TYPE[@SCHEMA=$theschema and not(COLLECTIONTYPE)]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Object Types</FONT></TD></TR>
		
		    <xsl:for-each select="//OBJECT_TYPE[@SCHEMA=$theschema]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject ) }.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject "/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
	
	    <!-- **************************** Packages ******************************* -->
		<xsl:if test="//PACKAGE[@SCHEMA=$theschema]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Packages</FONT></TD></TR>
		
		    <xsl:for-each select="//PACKAGE[@SCHEMA=$theschema]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject"/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
	
	
	    <!-- ****************************  Java ******************************* -->
		<xsl:if test="//JAVA[ @SCHEMA=$theschema and @TYPE='SOURCE' ]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Java Source</FONT></TD></TR>
		
		    <xsl:for-each select="//JAVA[ @SCHEMA=$theschema and @TYPE='SOURCE' ]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject"/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
	
	    <!-- **************************** Package and Object Bodies ******************************* -->
		<xsl:if test="//*[ @SCHEMA=$theschema and ( local-name() = 'PACKAGE_BODY' or local-name()='OBJECT_BODY' ) ]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Package and Object Type Bodies</FONT></TD></TR>
		
		    <xsl:for-each select="//*[ @SCHEMA=$theschema and ( local-name() = 'PACKAGE_BODY' or local-name()='OBJECT_BODY' ) ]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/_', $hrefObject )}_body.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject"/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
	
		<!-- **************************** Tables ******************************* -->
	    <xsl:if test="//TABLE[@SCHEMA=$theschema]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Tables</FONT></TD></TR>
		
		    <xsl:for-each select="//TABLE[@SCHEMA=$theschema]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject"/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
	
		<!-- **************************** Views ******************************* -->
	    <xsl:if test="//VIEW[@SCHEMA=$theschema]">
			<TABLE BORDER="1" WIDTH="100%">
			<TR><TD COLSPAN="2"><FONT size="+1" CLASS="FrameHeadingFont">Views</FONT></TD></TR>
		
		    <xsl:for-each select="//VIEW[@SCHEMA=$theschema]">
                      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
		      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
		      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
		      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
			  <TR>
		   	  <TD>
		        <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema,  '/', $hrefObject )}.html" TARGET="packageFrame">
		           <xsl:value-of select="$thisObject"/>
		        </A></FONT>
			    </TD>
			    <TD>&nbsp;</TD>
			  </TR>
		    </xsl:for-each>
		
			</TABLE>
			<P/><P/>
	    </xsl:if>
		
	    <!-- ***************************** FOOTER ****************************** -->
	    <xsl:call-template name="NavigationBar"/>
	
	    <FONT size="-1">
	    Generated by <A HREF="http://pldoc.sourceforge.net" TARGET="_blank">PLDoc</A>
	    </FONT>
	    </BODY>
	    </HTML>
	
    </redirect:write>
  </xsl:template>

  <!-- ********************** NAVIGATION BAR TEMPLATE ********************** -->
  <xsl:template name="NavigationBar">
    <TABLE BORDER="0" WIDTH="100%" CELLPADDING="1" CELLSPACING="0">
    <TR>
    <TD COLSPAN="2" CLASS="NavBarRow1">
    <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="3">
      <TR ALIGN="center" VALIGN="top">
      <TD CLASS="NavBarRow1Chosen"><FONT CLASS="NavBarFont1Chosen"><B>Overview</B></FONT> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="deprecated-list.html"><FONT CLASS="NavBarFont1"><B>Deprecated</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="index-list.html"><FONT CLASS="NavBarFont1"><B>Index</B></FONT></A> &nbsp;</TD>
      </TR>
    </TABLE>
    </TD>
    <TD ALIGN="right" VALIGN="top" rowspan="3"><EM>
      <b><xsl:value-of select="@NAME"/></b></EM>
    </TD>
    </TR>

    <TR>
    <TD CLASS="NavBarRow2">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;
    </TD>
    <TD CLASS="NavBarRow2"><FONT SIZE="-2">
      <A HREF="index.html" TARGET="_top"><B>FRAMES</B></A> &nbsp;&nbsp;
    </FONT></TD>
    </TR>
    <TR>
    <TD VALIGN="top" CLASS="NavBarRow3"><FONT SIZE="-2">
      SUMMARY:  FIELD | METHOD</FONT></TD>
    <TD VALIGN="top" CLASS="NavBarRow3"><FONT SIZE="-2">
    DETAIL:  FIELD | METHOD</FONT></TD>
    </TR>
    </TABLE>
    <HR/>
  </xsl:template>

</xsl:stylesheet>
