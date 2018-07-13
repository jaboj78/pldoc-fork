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
  xmlns:java="java"
  xmlns:str="http://exslt.org/strings"
  xmlns:lxslt="http://xml.apache.org/xslt"
  extension-element-prefixes="str java">

  <xsl:output method="html" indent="yes"/>

  <xsl:include href="common.xsl" />
	
	
	


  <xsl:key name="schemaInit" match="*[@SCHEMA]" use="@SCHEMA"/>

  <!-- ********************** NAVIGATION BAR TEMPLATE ********************** -->
  <xsl:template name="NavigationBar">
    <TABLE BORDER="0" WIDTH="100%" CELLPADDING="1" CELLSPACING="0">
    <TR>
    <TD COLSPAN="2" CLASS="NavBarRow1">
    <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="3">
      <TR ALIGN="center" VALIGN="top">
      <TD CLASS="NavBarRow1"><A HREF="summary.html"><FONT CLASS="NavBarFont1"><B>Overview</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1Chosen"><FONT CLASS="NavBarFont1Chosen"><B>Deprecated</B></FONT> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="index-list.html"><FONT CLASS="NavBarFont1"><B>Index</B></FONT></A> &nbsp;</TD>
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

  <!-- ************************* START OF PAGE ***************************** -->
  <xsl:template match="/APPLICATION">
    <HTML>
    <HEAD>
    <TITLE><xsl:value-of select="@NAME" />: Deprecated-List</TITLE>
    <LINK REL ="stylesheet" TYPE="text/css" HREF="stylesheet.css" TITLE="Style" />
    </HEAD>

    <BODY BGCOLOR="white">
    <!-- **************************** HEADER ******************************* -->
    <xsl:call-template name="NavigationBar"/>

    <CENTER><H2>Deprecated-List</H2></CENTER>
    <P/><P/>

    <!-- print deprecated Package and Object Type Specifications -->
    <xsl:if test="./PACKAGE/TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')] or ./OBJECT_TYPE/TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')] or ./PACKAGE_BODY/TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')] or ./OBJECT_BODY/TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')] ">
    
	    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
  	  <TR CLASS="TableHeadingColor">
   		<TD COLSPAN="2">
   		<FONT SIZE="+1"><B>
   		Packages, Object Types and Collections
   		</B></FONT></TD>
    	</TR> 

	    <xsl:for-each select="PACKAGE|OBJECT_TYPE|PACKAGE_BODY|OBJECT_BODY">
              <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>

        <xsl:if test="TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')]">
          <xsl:variable name="packagename" select="translate(@NAME,$namesFromCase, $namesToCase) "/>

		<!-- create link referrer -->
        	<xsl:variable name="referrer">
			<xsl:choose>
			<xsl:when test="translate(local-name(), $lowercase, $uppercase) = 'PACKAGE_BODY' or translate(local-name(), $lowercase, $uppercase) = 'OBJECT_BODY' ">
						<xsl:value-of select="concat('_',$packagename, '_body.html')"/>
			</xsl:when>
			<xsl:otherwise>
						<xsl:value-of select="concat($packagename, '.html')"/>
			</xsl:otherwise>
			</xsl:choose>
					</xsl:variable>
        							
					<TR>
					  <TD COLSPAN="2">
					    <!-- create link -->
					    <xsl:element name="A">
			        <xsl:attribute name="HREF">
					        <xsl:value-of select="translate($referrer,$uppercase,$lowercase)"/>
					      </xsl:attribute>
							  <xsl:value-of select="$packagename"/>        
							</xsl:element>
							
							<P/>

          	  <xsl:for-each select="TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')]">
        	      <xsl:for-each select="COMMENT">
                  <xsl:value-of select="." disable-output-escaping="yes" />
        	      </xsl:for-each>
          	  </xsl:for-each>

						</TD>
				  </TR>
				</xsl:if>
	    </xsl:for-each>  
	    
	    </TABLE>
	    <P/>
		</xsl:if>

    
    <!-- print function, procedures, triggers PACKAGE/child::*/TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')] -->
	<xsl:if test="/APPLICATION/*[local-name() = 'PACKAGE' or local-name() =  'OBJECT_TYPE' or  local-name() = 'PACKAGE_BODY' or local-name() =  'OBJECT_BODY'  ]/child::*/TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')]">
			
			<!-- print -->
	    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
  	  <TR CLASS="TableHeadingColor">
   		<TD COLSPAN="2">
   		<FONT SIZE="+1"><B>
   		Functions, Procedures, Triggers
   		</B></FONT></TD>
    	</TR> 

    	<xsl:for-each select="/APPLICATION/*[local-name() = 'PACKAGE' or local-name() =  'OBJECT_TYPE' or  local-name() = 'PACKAGE_BODY' or local-name() =  'OBJECT_BODY'  ]/child::*">
        <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>

	        <xsl:if test="TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')]">
	          <xsl:variable name="packagename" select="translate(../@NAME, $namesFromCase, $namesToCase)"/>
	          <xsl:variable name="objecttype" select="local-name(..)"/>

						  <TR>
						    <TD VALIGN="top">&nbsp;<xsl:value-of select="RETURN/@TYPE"/>&nbsp;</TD>
						    <TD>
							<!-- create link referrer -->
    							<xsl:variable name="referrer">
								<xsl:choose>
								<xsl:when test="translate($objecttype, $lowercase, $uppercase) = 'PACKAGE_BODY' or translate(local-name(), $lowercase, $uppercase) = 'OBJECT_BODY' ">
											<xsl:value-of select="concat('_',$packagename, '_body.html#')"/>
								</xsl:when>
								<xsl:otherwise>
											<xsl:value-of select="concat($packagename, '.html#')"/>
								</xsl:otherwise>
								</xsl:choose>
		    					      <xsl:value-of select="translate(@NAME,$namesFromCase, $namesToCase)" />
                        <xsl:if test="ARGUMENT">
                          <xsl:text>(</xsl:text>
        									<xsl:for-each select="ARGUMENT">
          									<xsl:value-of select="@TYPE"/>
          									<xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
        									</xsl:for-each>
        									<xsl:text>)</xsl:text>
        								</xsl:if>
    							</xsl:variable>
    							
    							<!-- nice presentation -->
    							<PRE>
							        <xsl:variable name="methodText">
			  								<B><xsl:value-of select="@NAME"/></B>
    								</xsl:variable>
    								<xsl:variable name="methodTextString" select="java:lang.String.new($methodText)"/>
									
									    <!-- create link -->
									    <xsl:element name="A">
	    					        <xsl:attribute name="HREF">
									        <xsl:value-of select="$referrer"/>
									      </xsl:attribute>
											  <xsl:value-of select="$methodTextString"/>        
											</xsl:element>
							
       							<!-- nice presentation (continued) -->
							        <xsl:text>(</xsl:text>
							        <xsl:for-each select="*[name()='ARGUMENT']">
							          <!-- pad arguments with appropriate number of spaces -->
		                    <xsl:if test="not(position()=1)">
		                      <BR/>
		                      <xsl:value-of select="str:padding(java:length($methodTextString)+1)"/>
		                    </xsl:if>
                      <xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
                      <xsl:if test="string-length(@MODE) &gt; 0">
                        <xsl:text> </xsl:text><xsl:value-of select="@MODE"/>
                      </xsl:if>
                      <xsl:text> </xsl:text><xsl:value-of select="@TYPE"/>
                      <xsl:if test="string-length(@DEFAULT) &gt; 0">
                        <xsl:text> DEFAULT </xsl:text><xsl:value-of select="@DEFAULT"/>
                      </xsl:if>
                      <xsl:if test="not(position()=last())">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                    </xsl:for-each>
                    <xsl:text>)</xsl:text>
                  </PRE>

										<P/>        							
          	        <xsl:for-each select="TAG[starts-with(translate(@TYPE, $lowercase, $uppercase),'@DEPRECATED')]">
        	            <xsl:for-each select="COMMENT">
                        <xsl:value-of select="." disable-output-escaping="yes" />
        	            </xsl:for-each>
          	        </xsl:for-each>
						    </TD>
						  </TR>
						  
    	    </xsl:if>
    	</xsl:for-each>
        	  
			</TABLE>
			<P/>
    </xsl:if>
    
	
    <!-- ***************************** FOOTER ****************************** -->
    <xsl:call-template name="NavigationBar"/>

    </BODY>
    </HTML>
  </xsl:template>

</xsl:stylesheet>
