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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>

  <xsl:variable name="uppercase">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
  <xsl:variable name="lowercase">abcdefghijklmnopqrstuvwxyz</xsl:variable>

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
      <TD CLASS="NavBarRow1"><A HREF="index-list.html"><FONT CLASS="NavBarFont1"><B>Index</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1Chosen"><FONT CLASS="NavBarFont1Chosen"><B>Generator</B></FONT> &nbsp;</TD>
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

  <!-- ************************* START OF PAGE ***************************** -->
  <xsl:template match="/APPLICATION">
    <HTML>
    <HEAD>
    <TITLE><xsl:value-of select="@NAME" />: Generator</TITLE>
    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style" />
    </HEAD>

    <BODY BGCOLOR="white">
    <!-- **************************** HEADER ******************************* -->
    <xsl:call-template name="NavigationBar"/>

    <CENTER><H2>Generator</H2></CENTER>

    <P/>

    <!-- **************************** APPLICATION ******************************* -->
		<xsl:apply-templates select="GENERATOR"/>
	
    <!-- ***************************** FOOTER ****************************** -->
    <xsl:call-template name="NavigationBar"/>

    </BODY>
    </HTML>
  </xsl:template>


	<!-- ***************************** GENERATOR ****************************** -->
  <xsl:template match="GENERATOR">
	  <P>
	  	<B>Created:</B>&nbsp;
	  	by PLDoc (${project.version}) on
  		<xsl:value-of select="CREATED/@DATE"/>&nbsp;-&nbsp;<xsl:value-of select="CREATED/@TIME"/>
  	</P>
  
		<!-- Draw Skipped versus Processed as a pie-chart -->
 		<!-- Draw Skipped versus Processed as a pie-chart -->
 		<P>
 		<xsl:variable name="numSkipped" select="OBJECTS/SKIPPED/@COUNT" /> 
 		<xsl:variable name="numProcessed" select="OBJECTS/PROCESSED/@COUNT" /> 
 		<xsl:variable name="numAttempted" select="$numSkipped + $numProcessed" /> 
 		<xsl:variable name="percentageSkipped" select="(100 * $numSkipped ) div $numAttempted" /> 
 		<xsl:variable name="percentageProcessed" select="(100 * $numProcessed ) div $numAttempted" /> 
 		<xsl:element name= "IMG">
 		  <xsl:attribute name="SRC" >
 <xsl:value-of select="concat('https://chart.googleapis.com//chart?cht=p3&amp;chd=t:', string($percentageSkipped),  ',', string($percentageProcessed), '&amp;chs=300x100&amp;chl=Skipped|Processed') " disable-output-escaping="yes" />  
 		  </xsl:attribute>
 		<!--
 		-->
 		</xsl:element>
 		</P>
 
		<P>
			<B>Objects successfully processed:</B>&nbsp;
			<xsl:value-of select="OBJECTS/PROCESSED/@COUNT"/>
		</P>
	
		<P>
			<B>Objects skipped:</B>&nbsp;
			<xsl:value-of select="OBJECTS/SKIPPED/@COUNT"/>
		</P>

		<xsl:apply-templates select="OBJECTS/SKIPPED"/>
		
  </xsl:template>
  
  
  
  <xsl:template match="OBJECTS/SKIPPED">
  	<xsl:if test="count(OBJECT) > 0">
  		<B>Failed objects:</B>
			<OL style="margin-top:10px;">
				<xsl:for-each select="OBJECT">
					<LI>
		  			<B><xsl:value-of select="translate(@NAME, $uppercase, $lowercase)"/></B>
		  			<BR/>
		  			<PRE style="background-color:whitesmoke; margin-top:5px; margin-bottom:35px;">
		  			<xsl:value-of select="@ERROR" disable-output-escaping="yes"/>
		  			</PRE>
		  		</LI>
				</xsl:for-each>
			</OL>
		</xsl:if>
  </xsl:template>

</xsl:stylesheet>
