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
<!--$Header: /cvsroot/pldoc/sources/src/resources/allpackages.xsl,v 1.3 2005/01/14 10:16:27 t_schaedler Exp $-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  extension-element-prefixes="str java"
  exclude-result-prefixes="java"
  >

  <xsl:output method="html" indent="yes"/>
  
  <xsl:include href="common.xsl" />
  

  <xsl:template match="/">
  <xsl:for-each select="APPLICATION">

    <HTML>
    <HEAD>
    <TITLE><xsl:value-of select="@NAME" /></TITLE>
    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style"/>
    </HEAD>
    <BODY BGCOLOR="white">

    <!--
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameTitleFont">
    <B><xsl:value-of select="@NAME" /></B></FONT></TD>
    </TR>
    </TABLE>
    -->

    <xsl:if test="OBJECT_TYPE[COLLECTIONTYPE]">
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Object Collections</FONT>
    <BR />
    <BR />

    <xsl:for-each select="OBJECT_TYPE[COLLECTIONTYPE]">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>

      <FONT CLASS="FrameItemFont"><A HREF="{concat($hrefSchema, '/', $hrefObject )}.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject"/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

    <xsl:if test="OBJECT_TYPE[not(COLLECTIONTYPE)]">
    <BR />
    <BR />
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Object Types</FONT>
    <BR />
    <BR />

    <xsl:for-each select="OBJECT_TYPE[not(COLLECTIONTYPE)]">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat($hrefSchema, '/', $hrefObject )}.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject "/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

    <!-- Defer treating Triggers as top-level objects
    <xsl:if test="TRIGGER">
    <BR />
    <BR />
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Triggers</FONT>
    <BR />
    <BR />

    <xsl:for-each select="TRIGGER">
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

    <xsl:if test="PACKAGE">
    <BR />
    <BR />
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Packages</FONT>
    <BR />
    <BR />

    <xsl:for-each select="PACKAGE">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat($hrefSchema, '/', $hrefObject) }.html" TARGET="packageFrame">
        <xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

    <xsl:if test="JAVA[@TYPE='SOURCE']">
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Java Source</FONT>
    <BR />
    <BR />

    <xsl:for-each select="JAVA[@TYPE='SOURCE' ]">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema, '/', $hrefObject )}.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject "/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

  <!-- Document Bodies Start -->

    <xsl:if test="PACKAGE_BODY|OBJECT_BODY">
    <BR />
    <BR />
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    Object and Package Bodies</FONT>
    <BR />
    <BR />

    <xsl:for-each select="PACKAGE_BODY|OBJECT_BODY">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat( $hrefSchema, '/_', $hrefObject )}_body.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject"/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

    <xsl:if test="*/TRIGGER[@TYPE='COMPOUND']">
    <BR />
    <BR />
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    Compound Trigger Bodies</FONT>
    <BR />
    <BR />

    <xsl:for-each select="*/TRIGGER[@TYPE='COMPOUND']">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat( $thisSchema, '/_', $hrefObject )}_body.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject"/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

  <!-- Document Bodies End -->

    <xsl:if test="TABLE">
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Tables</FONT>
    <BR></BR>

    <xsl:for-each select="TABLE">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat($hrefSchema, '/', $hrefObject )}.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject"/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

    <xsl:if test="VIEW">
    <TABLE BORDER="0" WIDTH="100%">
    <TR>
    <TD><FONT size="+1" CLASS="FrameHeadingFont">
    All Views</FONT>
    <BR></BR>

    <xsl:for-each select="VIEW">
      <xsl:sort select="translate(@NAME,$namesFromCase,$namesToCase)"/>
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
      <xsl:variable name="thisObject"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase) "/></xsl:variable>
      <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisObject  ))"/></xsl:variable>
      <FONT CLASS="FrameItemFont"><A HREF="{concat( $thisSchema, '/', $hrefObject )}.html" TARGET="packageFrame">
        <xsl:value-of select="$thisObject"/>
      </A></FONT><BR></BR>
    </xsl:for-each>

    </TD>
    </TR>
    </TABLE>
    </xsl:if>

    <P></P>
    </BODY>
    </HTML>
  </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
