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

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:exslt="http://exslt.org/common"
  xmlns:str="http://exslt.org/strings"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:java="http://xml.apache.org/xalan/java"
  extension-element-prefixes="str java"
  exclude-result-prefixes="java"
  >

  <xsl:output method="html" indent="yes"/>

  <xsl:include href="common.xsl" />
  <xsl:include href="common-exslt.xsl" />
	
  <xsl:key name="schemaInit" match="*[@SCHEMA]" use="@SCHEMA"/>

  <!-- ********************** NAVIGATION BAR TEMPLATE ********************** -->
  <xsl:template name="NavigationBar">
    <TABLE BORDER="0" WIDTH="100%" CELLPADDING="1" CELLSPACING="0">
    <TR>
    <TD COLSPAN="2" CLASS="NavBarRow1">
    <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="3">
      <TR ALIGN="center" VALIGN="top">
      <TD CLASS="NavBarRow1"><A HREF="summary.html"><FONT CLASS="NavBarFont1"><B>Overview</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="deprecated-list.html"><FONT CLASS="NavBarFont1"><B>Deprecated</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1Chosen"><FONT CLASS="NavBarFont1Chosen"><B>Index</B></FONT> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="generator.html"><FONT CLASS="NavBarFont1"><B>Generator</B></FONT></A> &nbsp;</TD>
      </TR>
    </TABLE>
    </TD>
    <TD ALIGN="right" VALIGN="top" rowspan="3"><EM>
      <b><xsl:value-of select="@NAME"/></b></EM>
    </TD>
    </TR>

    </TABLE>
    <HR/>
  </xsl:template>

  <!-- ************************* INDEX GROUP ***************************** -->
	<xsl:template name="IndexGroup">
    <xsl:param name="indexChar" />

    <DL>
		  <DT>
		  	<!-- anchor -->
		    <xsl:element name="A">
	        <xsl:attribute name="NAME"><xsl:value-of select="$indexChar"/></xsl:attribute>
				</xsl:element>
				<xsl:value-of select="$indexChar"/>
			</DT>
			
			<xsl:for-each select="OBJECT_TYPE/child::*">
		  	<xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
	        <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(../@SCHEMA) &gt; 0 " ><xsl:value-of select="../@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	       <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
				
				<xsl:if test="starts-with(translate(substring(@NAME, 1,1), $lowercase, $uppercase), $indexChar)">
				<DD>	
					<xsl:variable name="packagename" select="translate(../@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $packagename ))"/></xsl:variable>
					<xsl:variable name="methodname" select="translate(@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefMethod"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $methodname ))"/></xsl:variable>
					<!-- create link referrer -->
					<xsl:variable name="referrer">
					      <xsl:value-of select="concat($hrefSchema, '/', $hrefObject)"/>
   					      <xsl:value-of select="'.html#'"/>
						<xsl:value-of select="$hrefMethod" />
						       <xsl:if test="ARGUMENT">
							<xsl:text>(</xsl:text>
								<xsl:for-each select="ARGUMENT">
 									<xsl:value-of select="@TYPE"/>
 									<xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
								</xsl:for-each>
								<xsl:text>)</xsl:text>
							</xsl:if>
					</xsl:variable>
									
			    <!-- create link -->
			    <xsl:element name="A">
			      <xsl:attribute name="HREF">
			        <xsl:value-of select="translate($referrer,$uppercase,$lowercase)"/>
			      </xsl:attribute>
			    	<xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>        
			    </xsl:element>
					
					&nbsp; <FONT SIZE="-1">(<xsl:value-of select="$packagename"/>)</FONT>
					
					<BR/>
				  
				  <!-- xsl:value-of select="COMMENT_FIRST_LINE"/ -->
					<xsl:call-template name="processInlineTag">
						<xsl:with-param name="comment" select="COMMENT_FIRST_LINE" />
						<xsl:with-param name="tag" select="'link'" />
					</xsl:call-template>
				  
				  <P/>
				</DD>
				</xsl:if>

		</xsl:for-each>

			<xsl:for-each select="PACKAGE/child::*">
				<xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
		       <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(../@SCHEMA) &gt; 0 " ><xsl:value-of select="../@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
		       <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
				
				<xsl:if test="starts-with(translate(substring(@NAME, 1,1), $lowercase, $uppercase), $indexChar)">
				<DD>	
					<xsl:variable name="packagename" select="translate(../@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $packagename ))"/></xsl:variable>
					<xsl:variable name="methodname" select="translate(@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefMethod"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $methodname ))"/></xsl:variable>
					<!-- create link referrer -->
					<xsl:variable name="referrer">
					      <xsl:value-of select="concat($hrefSchema, '/', $hrefObject) "/>
   					      <xsl:value-of select="'.html#'"/>
						<xsl:value-of select="$hrefMethod" />
						       <xsl:if test="ARGUMENT">
							<xsl:text>(</xsl:text>
								<xsl:for-each select="ARGUMENT">
 									<xsl:value-of select="@TYPE"/>
 									<xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
								</xsl:for-each>
								<xsl:text>)</xsl:text>
							</xsl:if>
					</xsl:variable>
									
			    <!-- create link -->
			    <xsl:element name="A">
				<xsl:attribute name="HREF">
			        <xsl:value-of select="$referrer"/>
			      </xsl:attribute>
			    	<xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>        
					</xsl:element>
					
					&nbsp; <FONT SIZE="-1">(<xsl:value-of select="$packagename"/>)</FONT>
					
					<BR/>
				  
					<!-- xsl:value-of select="COMMENT_FIRST_LINE"/ -->
					<xsl:call-template name="processInlineTag">
						<xsl:with-param name="comment" select="COMMENT_FIRST_LINE" />
						<xsl:with-param name="tag" select="'link'" />
					</xsl:call-template>
					
				  <P/>
				</DD>
				</xsl:if>

		</xsl:for-each>

<!-- Include Bodies in the index Start -->
			<xsl:for-each select="OBJECT_BODY/child::*">
				<xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
			        <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(../@SCHEMA) &gt; 0 " ><xsl:value-of select="../@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
			       <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
				
				<xsl:if test="starts-with(translate(substring(@NAME, 1,1), $lowercase, $uppercase), $indexChar)">
				<DD>	
					<xsl:variable name="packagename" select="translate(../@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $packagename ))"/></xsl:variable>
					<xsl:variable name="methodname" select="translate(@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefMethod"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $methodname ))"/></xsl:variable>
					<!-- create link referrer -->
					<xsl:variable name="referrer">
					      <xsl:value-of select="concat($hrefSchema, '/', '_') "/>
					      <xsl:value-of select="$hrefObject"/>
   					      <xsl:value-of select="'_body.html#'"/>
					      <xsl:value-of select="$hrefMethod" />
						       <xsl:if test="ARGUMENT">
							<xsl:text>(</xsl:text>
								<xsl:for-each select="ARGUMENT">
 									<xsl:value-of select="@TYPE"/>
 									<xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
								</xsl:for-each>
								<xsl:text>)</xsl:text>
							</xsl:if>
					</xsl:variable>
									
			    <!-- create link -->
			    <xsl:element name="A">
				<xsl:attribute name="HREF">
			        <xsl:value-of select="$referrer"/>
			      </xsl:attribute>
			    	<xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>        
					</xsl:element>
					
					&nbsp; <FONT SIZE="-1">(<xsl:value-of select="$packagename"/> body)</FONT>
					
					<BR/>
				  
					<!-- xsl:value-of select="COMMENT_FIRST_LINE"/ -->
					<xsl:call-template name="processInlineTag">
						<xsl:with-param name="comment" select="COMMENT_FIRST_LINE" />
						<xsl:with-param name="tag" select="'link'" />
					</xsl:call-template>
					
				  <P/>
				</DD>
				</xsl:if>

		</xsl:for-each>

			<xsl:for-each select="PACKAGE_BODY/child::*">
				<xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
			        <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(../@SCHEMA) &gt; 0 " ><xsl:value-of select="../@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
				<xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $thisSchema ))"/></xsl:variable>
				
				<xsl:if test="starts-with(translate(substring(@NAME, 1,1), $lowercase, $uppercase), $indexChar)">
				<DD>	
					<xsl:variable name="packagename" select="translate(../@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefObject"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $packagename ))"/></xsl:variable>
					<xsl:variable name="methodname" select="translate(@NAME, $namesFromCase, $namesToCase)"/>
				        <xsl:variable name="hrefMethod"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $methodname ))"/></xsl:variable>
					<!-- create link referrer -->
					<xsl:variable name="referrer">
					      <xsl:value-of select="concat($hrefSchema, '/','_') "/>
					      <xsl:value-of select="$hrefMethod"/>
   					      <xsl:value-of select="'_body.html#'"/>
						<xsl:value-of select="$hrefMethod" />
						       <xsl:if test="ARGUMENT">
							<xsl:text>(</xsl:text>
								<xsl:for-each select="ARGUMENT">
 									<xsl:value-of select="@TYPE"/>
 									<xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
								</xsl:for-each>
								<xsl:text>)</xsl:text>
							</xsl:if>
					</xsl:variable>
									
			    <!-- create link -->
			    <xsl:element name="A">
				<xsl:attribute name="HREF">
			        <xsl:value-of select="$referrer"/>
			      </xsl:attribute>
			    	<xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>        
					</xsl:element>
					
					&nbsp; <FONT SIZE="-1">(<xsl:value-of select="$packagename"/> body)</FONT>
					
					<BR/>
				  
					<!-- xsl:value-of select="COMMENT_FIRST_LINE"/ -->
					<xsl:call-template name="processInlineTag">
						<xsl:with-param name="comment" select="COMMENT_FIRST_LINE" />
						<xsl:with-param name="tag" select="'link'" />
					</xsl:call-template>
					
				  <P/>
				</DD>
				</xsl:if>

		</xsl:for-each>
<!-- Include Bodies in the index End -->

<!-- Include Bodies in the index End -->

		</DL>

	</xsl:template>

  <!-- ************************* START OF PAGE ***************************** -->
  <xsl:template match="/APPLICATION">
    <HTML>
    <HEAD>
    <TITLE><xsl:value-of select="@NAME" />: Index-List</TITLE>
    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style" />
    	<xsl:comment>
        sameCase=<xsl:value-of select="$samecase" />
        namesLowerCase=<xsl:value-of select="$namesLowerCase"  />
        namesUpperCase=<xsl:value-of select="$namesUpperCase"  />
        namesDefaultCase=<xsl:value-of select="$namesDefaultCase"  />
        defaultNamesCase=<xsl:value-of select="$defaultNamesCase"  />
        namesFromCase=<xsl:value-of select="$namesFromCase" />
        namesToCase=<xsl:value-of select="$namesToCase" />
      </xsl:comment>
    </HEAD>

    <BODY BGCOLOR="white">
    <!-- **************************** HEADER ******************************* -->
    <xsl:call-template name="NavigationBar"/>

    <CENTER><H2>Index</H2></CENTER>
    <P/><P/>

		<!-- Index links -->
		<A HREF="#A">A</A> &nbsp;
		<A HREF="#B">B</A> &nbsp;
		<A HREF="#C">C</A> &nbsp;
		<A HREF="#D">D</A> &nbsp;
		<A HREF="#E">E</A> &nbsp;
		<A HREF="#F">F</A> &nbsp;
		<A HREF="#G">G</A> &nbsp;
		<A HREF="#H">H</A> &nbsp;
		<A HREF="#I">I</A> &nbsp;
		<A HREF="#J">J</A> &nbsp;
		<A HREF="#K">K</A> &nbsp;
		<A HREF="#L">L</A> &nbsp;
		<A HREF="#M">M</A> &nbsp;
		<A HREF="#N">N</A> &nbsp;
		<A HREF="#O">O</A> &nbsp;
		<A HREF="#P">P</A> &nbsp;
		<A HREF="#Q">Q</A> &nbsp;
		<A HREF="#R">R</A> &nbsp;
		<A HREF="#S">S</A> &nbsp;
		<A HREF="#T">T</A> &nbsp;
		<A HREF="#U">U</A> &nbsp;
		<A HREF="#V">V</A> &nbsp;
		<A HREF="#W">W</A> &nbsp;
		<A HREF="#X">X</A> &nbsp;
		<A HREF="#Y">Y</A> &nbsp;
		<A HREF="#Z">Z</A> &nbsp;

		<!-- for each group construct is not standard XSLT -->
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">A</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">B</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">C</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">D</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">E</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">F</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">G</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">H</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">I</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">J</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">K</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">L</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">M</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">N</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">O</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">P</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">Q</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">R</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">S</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">T</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">U</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">V</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">X</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">Y</xsl:with-param></xsl:call-template>
    <xsl:call-template name="IndexGroup"><xsl:with-param name="indexChar">Z</xsl:with-param></xsl:call-template>



    
	
    <!-- ***************************** FOOTER ****************************** -->
    <xsl:call-template name="NavigationBar"/>

    </BODY>
    </HTML>
  </xsl:template>

</xsl:stylesheet>
