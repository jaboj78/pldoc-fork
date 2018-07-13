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
<!--$Header: /cvsroot/pldoc/sources/src/resources/unit.xsl,v 1.5 2004/07/06 13:04:58 altumano Exp $-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:java="java"
  xmlns:exslt="http://exslt.org/common"
  xmlns:str="http://exslt.org/strings"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
  extension-element-prefixes="redirect str java">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:include href="common.xsl" />
  <xsl:include href="common-exslt.xsl" />
  
  <xsl:param name="targetFolder"/>
  <xsl:param name="sourceRootFolder"/>
  <xsl:param name="synonymsFile"/>




<!-- ********************** NAVIGATION BAR TEMPLATE ********************** -->
  <xsl:template name="NavigationBar">
    <TABLE BORDER="0" WIDTH="100%" CELLPADDING="1" CELLSPACING="0">
    <TR>
    <TD COLSPAN="2" CLASS="NavBarRow1">
    <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="3">
      <TR ALIGN="center" VALIGN="top">
      <TD CLASS="NavBarRow1"><A HREF="../summary.html"><FONT CLASS="NavBarFont1"><B>Overview</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="../deprecated-list.html"><FONT CLASS="NavBarFont1"><B>Deprecated</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="../index-list.html"><FONT CLASS="NavBarFont1"><B>Index</B></FONT></A> &nbsp;</TD>
      <TD CLASS="NavBarRow1"><A HREF="../generator.html"><FONT CLASS="NavBarFont1"><B>Generator</B></FONT></A> &nbsp;</TD>
      </TR>
    </TABLE>
    </TD>
    <TD ALIGN="right" VALIGN="top" rowspan="3"><EM>
      <b><xsl:value-of select="../@NAME"/></b></EM>
    </TD>
    </TR>

    <TR>
    <TD VALIGN="top" CLASS="NavBarRow3"><FONT SIZE="-2">
      SUMMARY:  <A HREF="#field_summary">FIELD</A> | <A HREF="#type_summary">TYPE</A> | <A HREF="#method_summary">METHOD</A></FONT></TD>
    <TD VALIGN="top" CLASS="NavBarRow3"><FONT SIZE="-2">
    DETAIL:  <A HREF="#field_detail">FIELD</A> | <A HREF="#type_detail">TYPE</A> | <A HREF="#method_detail">METHOD</A></FONT></TD>
    </TR>
    </TABLE>
    <HR/>
  </xsl:template>

  <!-- ***************** CUSTOM TAGS TEMPLATE ****************** -->
  <!-- Special defined custom tags are processed here ! -->
  <xsl:template name="CustomTagsTemplate">

	<DL>
		<!-- deprecated -->
        <xsl:if test="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
  	      <DT>Deprecated:</DT>
		  <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
	        <DD>
	        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
	        </xsl:for-each>
	        </DD>
	      </xsl:for-each>
	      <P/>
        </xsl:if>
		
		<!-- value -->
        <xsl:if test="TAG[@TYPE='@value' or @TYPE='@VALUE' ]">
          <DT>Value:</DT>
          <xsl:for-each select="TAG[@TYPE='@value' or @TYPE='@VALUE' ]">
            <DD><CODE><xsl:value-of select="@NAME"/></CODE> -
              <xsl:for-each select="COMMENT">
              <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
              <xsl:call-template name="processInlineTag">
                <xsl:with-param name="comment" select="." />
                <xsl:with-param name="tag" select="'link'" />
              </xsl:call-template>
              </xsl:for-each>
            </DD>
          </xsl:for-each>
        </xsl:if>
        
		<!-- usage -->
        <xsl:if test="TAG[@TYPE='@usage' or @TYPE='@USAGE']">
          <DT>Usage:</DT>
          <xsl:for-each select="TAG[@TYPE='@usage' or @TYPE='@USAGE' ]">
            <DD>
              <xsl:for-each select="COMMENT">
                <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
                <xsl:call-template name="processInlineTag">
                  <xsl:with-param name="comment" select="." />
                  <xsl:with-param name="tag" select="'link'" />
                </xsl:call-template>
              </xsl:for-each>
            </DD>
          </xsl:for-each>
        </xsl:if>
        
		<!-- author -->
        <xsl:if test="TAG[@TYPE='@author' or @TYPE='@AUTHOR' ]">
          <DT>Author:</DT>
          <xsl:for-each select="TAG[@TYPE='@author' or @TYPE='@AUTHOR' ]">
            <DD>
              <xsl:for-each select="COMMENT">
                <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
                <xsl:call-template name="processInlineTag">
                  <xsl:with-param name="comment" select="." />
                  <xsl:with-param name="tag" select="'link'" />
                </xsl:call-template>
              </xsl:for-each>
            </DD>
          </xsl:for-each>
        </xsl:if>
        
		<!-- version -->
        <xsl:if test="TAG[@TYPE='@version' or @TYPE='@VERSION' ]">
          <DT>Version:</DT>
          <xsl:for-each select="TAG[@TYPE='@version' or @TYPE='@VERSION' ]">
            <DD>
              <xsl:for-each select="COMMENT">
                <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
                <xsl:call-template name="processInlineTag">
                  <xsl:with-param name="comment" select="." />
                  <xsl:with-param name="tag" select="'link'" />
                </xsl:call-template>
              </xsl:for-each>
            </DD>
          </xsl:for-each>
        </xsl:if>

		<!-- since -->
        <xsl:if test="TAG[@TYPE='@since' or @TYPE='@SINCE' ]">
          <DT>Since:</DT>
          <xsl:for-each select="TAG[@TYPE='@since' or @TYPE='@SINCE' ]">
            <DD>
              <xsl:for-each select="COMMENT">
                <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
                <xsl:call-template name="processInlineTag">
                  <xsl:with-param name="comment" select="." />
                  <xsl:with-param name="tag" select="'link'" />
                </xsl:call-template>
              </xsl:for-each>
            </DD>
          </xsl:for-each>
        </xsl:if>
        
		<!-- see -->
        <xsl:if test="TAG[@TYPE='@see' or @TYPE='@SEE'   ]">
          <DT>See also:</DT>
          <xsl:for-each select="TAG[@TYPE='@see' or @TYPE='@SEE' ]">
            <DD>
              <xsl:for-each select="COMMENT">
            <!--
            <xsl:comment>
              CustomTagsTemplate.FoundComment=START<xsl:value-of select="." disable-output-escaping="yes"/>END
              CustomTagsTemplate.FoundCommentText=START<xsl:value-of select="text()" disable-output-escaping="yes"/>END
            </xsl:comment>
            -->
	            <A>
            	<xsl:choose>
            	  <xsl:when test="starts-with(., '&lt;') or starts-with(., 'http://') or starts-with(., 'https://')"> <!-- External Link pass out unmodified-->
            	    <xsl:attribute name="href"><xsl:value-of select="." disable-output-escaping="yes"/></xsl:attribute>
            	    <xsl:value-of select="." disable-output-escaping="yes"/>
            	  </xsl:when>
            	  <xsl:when test="starts-with(., '#')"> <!-- Internal Link -->
                	<xsl:attribute name="href"><xsl:value-of select="." disable-output-escaping="yes"/></xsl:attribute>
                	<xsl:value-of select="substring-after(., '#')" disable-output-escaping="yes"/>
            	  </xsl:when>
            	  <xsl:otherwise>
  	            	<xsl:choose>
	            	  <xsl:when test="string-length(substring-before(., '#')) &lt; 1">
	               		<xsl:attribute name="href"><xsl:value-of select="translate(., $uppercase, $lowercase)" disable-output-escaping="yes"/>.html</xsl:attribute>
	               		<xsl:value-of select="." disable-output-escaping="yes"/>
	            	  </xsl:when>
                	  <xsl:otherwise>
	               		<xsl:attribute name="href"><xsl:value-of select="translate(concat(substring-before(., '#'), '.html#', substring-after(., '#')) ,$uppercase, $lowercase) " disable-output-escaping="yes"/></xsl:attribute>
	               		<xsl:value-of select="substring-before(., '#')" disable-output-escaping="yes"/>.<xsl:value-of select="substring-after(., '#')" disable-output-escaping="yes"/>
                	  </xsl:otherwise>
  	                </xsl:choose>
            	  </xsl:otherwise>
            	</xsl:choose>
            	</A>
              </xsl:for-each>
            </DD>
          </xsl:for-each>
        </xsl:if>
        
	</DL>     
	   
  </xsl:template>

  <!-- ***************** TYPE name to OBJECT TYPE LINK TEMPLATE ****************** -->
  <!-- If possible, convert the plain-text TYPE name to a link to a matching OBJECT TYPE in the Application -->
  <xsl:template name="GenerateTypeLink">
    <xsl:param name="typeName" />
    <xsl:param name="schemaName" />
    <xsl:param name="localTypeName" />
    <xsl:variable name="schema" select="translate($schemaName, $namesFromCase, $namesToCase)" />
    <xsl:variable name="fieldType" select="translate($typeName, $namesFromCase, $namesToCase)" />
   <xsl:comment>
       schemaName=<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>
       typeName=<xsl:value-of select="$typeName" disable-output-escaping="yes"/>
       localTypeName=<xsl:value-of select="$localTypeName" disable-output-escaping="yes"/>
       schema=<xsl:value-of select="$schema" disable-output-escaping="yes"/>
       fieldType=<xsl:value-of select="$fieldType" disable-output-escaping="yes"/>
       synonymsFile=<xsl:value-of select="concat( ',', $synonymsFile, ',' ) " disable-output-escaping="yes"/>
   </xsl:comment>
      <xsl:choose>
      <xsl:when test=" string-length($localTypeName) > 0  ">
           <xsl:comment>localTypeNameParameter</xsl:comment>
	    <A>
	      <xsl:attribute name="href">#<xsl:value-of select="translate($localTypeName, $namesFromCase, $namesToCase)" disable-output-escaping="yes"/></xsl:attribute>
		<xsl:value-of select="$typeName" disable-output-escaping="yes"/>
            </A>
      </xsl:when>

        <xsl:when test="/APPLICATION/OBJECT_TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = $fieldType and translate(@SCHEMA, $namesFromCase, $namesToCase) = $schema ] ">
           <xsl:comment>Object Type in same schema</xsl:comment>
	    <A>
		<xsl:attribute name="href"><xsl:value-of select="$fieldType" disable-output-escaping="yes"/>.html</xsl:attribute>
		<xsl:value-of select="$typeName" disable-output-escaping="yes"/>
            </A>
      </xsl:when>
	<xsl:when test=" $synonymsFile != '' and document($synonymsFile)/SYNONYMS/SYNONYM[@OWNER = $schema and @SYNONYM_NAME = $fieldType ] ">
	    <xsl:comment>Object Type in other schema - use private synonym </xsl:comment>
	    <xsl:variable name="referencedOwner" select="document($synonymsFile)/SYNONYMS/SYNONYM[@OWNER = $schema and @SYNONYM_NAME = $fieldType ]/@TABLE_OWNER " /> 
	    <xsl:variable name="hrefReferencedOwner"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $referencedOwner ))"/></xsl:variable>
	    <xsl:variable name="referencedObject" select="document($synonymsFile)/SYNONYMS/SYNONYM[@OWNER = $schema and @SYNONYM_NAME = $fieldType ]/@TABLE_NAME " /> 
	    <A>
	    <xsl:attribute name="href"><xsl:value-of select="concat( '../' , $hrefReferencedOwner,  '/' , $referencedObject )" disable-output-escaping="yes"/>.html</xsl:attribute>
	      <xsl:value-of select="$typeName" disable-output-escaping="yes"/>
	  </A>
	</xsl:when>
        <xsl:when test="/APPLICATION/OBJECT_TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = $fieldType ] ">
           <xsl:comment>Object Type in any schema - choose first</xsl:comment>
	    <A>
	      <xsl:attribute name="href"><xsl:value-of select="concat( '../' , /APPLICATION/OBJECT_TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = $fieldType][1]/@SCHEMA, '/' , $fieldType )" disable-output-escaping="yes"/>.html</xsl:attribute>
	      <xsl:value-of select="$typeName" disable-output-escaping="yes"/>
            </A>
      </xsl:when>
     <!-- Package Type owned by same schema -->
        <xsl:when test="contains ($typeName, '.') 
                        and /APPLICATION/PACKAGE[ translate(@SCHEMA, $uppercase, $lowercase)  = translate($schema, $uppercase, $lowercase)  
       and translate(@NAME, $namesFromCase, $namesToCase)  = translate(substring-before($typeName,'.'), $namesFromCase, $namesToCase)  ]/TYPE[ translate(@NAME, $namesFromCase, $namesToCase)  = translate(substring-after($typeName,'.'), $namesFromCase, $namesToCase)  ] ">
	    <xsl:comment>Packaged PL/SQL Type in same schema </xsl:comment>
	    <A>
	      <xsl:attribute name="href"><xsl:value-of select="concat(translate(substring-before($typeName,'.'),  $namesFromCase, $namesToCase) , '.html#', translate(substring-after($typeName,'.'), $namesFromCase, $namesToCase) )" disable-output-escaping="yes"/></xsl:attribute>
		<xsl:value-of select="$typeName" disable-output-escaping="yes"/>
            </A>
      </xsl:when>
     <!-- Object Type owned by another schema and explicitly referenced by schema name rather than by synonym -->
     <xsl:when test="contains ($typeName, '.') and /APPLICATION/OBJECT_TYPE[ translate(@SCHEMA, $uppercase, $lowercase)  = translate(substring-before($typeName,'.'), $uppercase, $lowercase)  
       and translate(@NAME, $namesFromCase, $namesToCase) = translate(substring-after($typeName,'.'), $namesFromCase, $namesToCase)  ] ">
   <xsl:comment>Object Type in specified schema </xsl:comment>
	<A>
	    <xsl:attribute name="href"><xsl:value-of select="concat ( '../',  translate(substring-before($typeName,'.'), $namesFromCase, $namesToCase) ,'/', translate(substring-after($typeName,'.'), $namesFromCase, $namesToCase) )" disable-output-escaping="yes"/>.html</xsl:attribute>
	    <xsl:value-of select="$typeName" disable-output-escaping="yes"/>
	</A>
     </xsl:when>
     <!-- Explicitly referenced Package Type owned by other schema -->
     <xsl:when test="contains ($typeName, '.') and /APPLICATION/PACKAGE[ translate(@SCHEMA, $uppercase, $lowercase)  = translate(substring-before($typeName,'.'), $uppercase, $lowercase)  
       and translate(@NAME, $namesFromCase, $namesToCase)  = substring-before(substring-after($fieldType, '.'),'.')  ]/TYPE[ translate(@NAME, $namesFromCase, $namesToCase)  = substring-after(substring-after($fieldType,'.'),'.') ] ">
       <xsl:comment>Explicitly Referenced Packaged PL/SQL Type in specified schema </xsl:comment>
	    <A>
		<xsl:attribute name="href"><xsl:value-of select="concat('../', translate(substring-before($typeName,'.'), $namesFromCase, $namesToCase) , '/',translate(substring-before(substring-after($typeName,'.'),'.'), $namesFromCase, $namesToCase), '.html#', translate(substring-after(substring-after($typeName,'.'),'.'), $namesFromCase, $namesToCase) )" disable-output-escaping="yes"/></xsl:attribute>
	      <xsl:value-of select="translate($typeName, $namesFromCase, $namesToCase)" disable-output-escaping="yes"/>
            </A>
     </xsl:when>
     <!-- Implicitly referenced Package Type owned by other schema -->
     <xsl:when test="contains ($typeName, '.') 
                    and $synonymsFile != '' and document($synonymsFile)/SYNONYMS/SYNONYM[@OWNER = $schema and @SYNONYM_NAME = substring-after($fieldType,'.') ] ">
	    <xsl:comment>PLSQL Type in other schema - use private synonym </xsl:comment>
	    <xsl:variable name="referencedOwner" select="document($synonymsFile)/SYNONYMS/SYNONYM[@OWNER = $schema and @SYNONYM_NAME = substring-after($fieldType,'.') ]/@TABLE_OWNER " /> 
	    <xsl:variable name="hrefReferencedOwner"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $referencedOwner ))"/></xsl:variable>
	    <xsl:variable name="referencedObject" select="document($synonymsFile)/SYNONYMS/SYNONYM[@OWNER = $schema and @SYNONYM_NAME = substring-after($fieldType,'.') ]/@TABLE_NAME " /> 
	    <A>
	    <xsl:attribute name="href"><xsl:value-of select="concat( '../' , $hrefReferencedOwner, '/' , $referencedObject )" disable-output-escaping="yes"/>.html</xsl:attribute>
	      <xsl:value-of select="$typeName" disable-output-escaping="yes"/>
	  </A>
	</xsl:when>
       <xsl:when test="contains ($typeName, '.') 
                        and /APPLICATION/PACKAGE[ translate(@NAME, $namesFromCase, $namesToCase)  = substring-before($fieldType,'.') ]/TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = substring-after($fieldType,'.')  ] ">
       <xsl:comment>Implicitly referenced Packaged PL/SQL Type in any schema </xsl:comment>

       <xsl:variable name="packageSchema" select="/APPLICATION/PACKAGE[ translate(@NAME, $namesFromCase, $namesToCase) = substring-before($fieldType,'.') ]/TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = substring-after($fieldType,'.') ][1]/../@SCHEMA" />
<!-- <xsl:variable name="hrefPackageSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, translate($packageSchema, $namesFromCase, $namesToCase) ))"/></xsl:variable>

       This variable derivation fails with an NPE and ClassNotFoundException - revert until solution found 

       All input was "sys"

       SystemId Unknown; Line #0; Column #0; javax.xml.transform.TransformerException: java.lang.ClassNotFoundException: java.java.net.URI
       SystemId Unknown; Line #315; Column #47; java.lang.NullPointerException
-->
       <xsl:variable name="hrefPackageSchema"><xsl:value-of select="translate($packageSchema, $namesFromCase, $namesToCase)"/></xsl:variable>

	    <A>
		<xsl:attribute name="href"><xsl:value-of select="concat('../', $hrefPackageSchema , '/',translate(substring-before($typeName,'.'), $namesFromCase, $namesToCase), '.html#', translate(substring-after(substring-after($typeName,'.'),'.'), $namesFromCase, $namesToCase) )" disable-output-escaping="yes"/></xsl:attribute>
	      <xsl:value-of select="translate($typeName, $namesFromCase, $namesToCase)" disable-output-escaping="yes"/>
            </A>
     </xsl:when>
     <xsl:otherwise>
       <xsl:comment>GenerateTypeLink: default reached</xsl:comment>
       <xsl:value-of select="translate($typeName, $namesFromCase, $namesToCase)" />
     </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- -->

    
    
  <!-- ***************** METHOD/TYPE/TRIGGER SUMMARY TEMPLATE ****************** -->
  <xsl:template name="MethodOrTypeOrTriggerSummary">
    <xsl:param name="fragmentName" />
    <xsl:param name="title" />
    <xsl:param name="mainTags" />
    <xsl:param name="childTags" />
    <xsl:param name="flagTrigger" />

    <A NAME="{$fragmentName}"></A>
    <xsl:if test="$mainTags">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="2"><FONT SIZE="+2">
    <B><xsl:value-of select="$title"/></B></FONT></TD>
    </TR>

    <xsl:for-each select="$mainTags">
      <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      <TR CLASS="TableRowColor">
      <TD ALIGN="right" VALIGN="top" WIDTH="1%"><FONT SIZE="-1">
      <CODE><xsl:text>&nbsp;</xsl:text>
      <!-- 20110428 <xsl:value-of select="RETURN/@TYPE"/> -->
      <!-- If possible, convert the plain-text TYPE to a link to a matching OBJECT TYPE in the Application-->
      <xsl:variable name="fieldType" select="translate(RETURN/@TYPE, $uppercase, $lowercase)" />
      <xsl:call-template name="GenerateTypeLink">
	    <xsl:with-param name="typeName" select="RETURN/@TYPE" />
            <xsl:with-param name="schemaName" select="ancestor-or-self::*/@SCHEMA"/>
            <xsl:with-param name="localTypeName" select="../TYPE[ translate(@NAME, $uppercase, $lowercase) = $fieldType ]/@NAME" />
      </xsl:call-template>
      </CODE></FONT></TD>
	<xsl:variable name="nameLowerCase" select="translate(@NAME, $uppercase, $lowercase)" />
	<xsl:comment> 
		siblingCount=<xsl:value-of select="count(preceding-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase) ]) + count(following-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase)])" /> 
		argumentCount=<xsl:value-of select="count(ARGUMENT)" /> 
		predecessorCount=<xsl:value-of select="count(preceding-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase)])" /> 
		siblingNoArgumentCount=<xsl:value-of select="count(preceding-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase) and not(ARGUMENT) ]) + count(following-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase) and not(ARGUMENT) ])" /> 
	</xsl:comment>
	<xsl:variable name="arguments" select="count(ARGUMENT)" /> 
	<xsl:variable name="predecessors" select="count(preceding-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase)])" /> 
	<xsl:variable name="siblingsWithoutArguments" select="count(preceding-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase) and not(ARGUMENT) ]) + count(following-sibling::*[$nameLowerCase = translate(@NAME,$uppercase,$lowercase) and not(ARGUMENT) ])" /> 
	<xsl:if test="( $arguments > 0 and $predecessors = 0 and $siblingsWithoutArguments = 0 ) or translate(RETURN/@TYPE,$lowercase,$uppercase) = 'RECORD'" >
	<xsl:element name="A"><xsl:attribute name="NAME"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)" /></xsl:attribute></xsl:element>
	</xsl:if>
      <TD><CODE>
        <B><xsl:element name="A"><xsl:attribute name="HREF">#<xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)" />
        <xsl:if test="*[name()=$childTags]">
        <xsl:text>(</xsl:text>
        <xsl:for-each select="*[name()=$childTags]">
          <xsl:value-of select="translate(@TYPE, $namesFromCase, $namesToCase)" />
          <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text>)</xsl:text>
        </xsl:if>
        </xsl:attribute><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></xsl:element></B>
        <xsl:if test="not($flagTrigger)"><xsl:text>(</xsl:text></xsl:if>
        <xsl:for-each select="*[name()=$childTags]">
          <xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
          <xsl:if test="string-length(@MODE) &gt; 0">
            <xsl:text> </xsl:text><xsl:value-of select="@MODE"/>
          </xsl:if>
          <xsl:text> </xsl:text><xsl:value-of select="@TYPE"/>
          <xsl:if test="string-length(@DEFAULT) &gt; 0">
            <xsl:text> DEFAULT </xsl:text><xsl:value-of select="@DEFAULT"/>
          </xsl:if>
          <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:if test="not($flagTrigger)"><xsl:text>)</xsl:text></xsl:if>
        </CODE>
      <BR/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <xsl:if test="not(./TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ])">
        <xsl:for-each select="COMMENT_FIRST_LINE">
          <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
      <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
        <B>Deprecated.</B>&nbsp;<I>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each></I>
      </xsl:for-each>
      </TD>
      </TR>
    </xsl:for-each>

    </TABLE>
    <P/>

    </xsl:if>
  </xsl:template>

  <!-- ************************* METHOD/TYPE/TRIGGER DETAIL TEMPLATE *************************** -->
  <xsl:template name="MethodOrTypeOrTriggerDetail">
    <xsl:param name="fragmentName" />
    <xsl:param name="title" />
    <xsl:param name="mainTags" />
    <xsl:param name="childTags" />
    <xsl:param name="flagTrigger" />
    <xsl:param name="childDescription" /> <!-- 11G Trigger Changes-->
    
    <A NAME="{$fragmentName}"></A>
    <xsl:if test="$mainTags">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="1"><FONT SIZE="+2">
    <B><xsl:value-of select="$title"/></B></FONT></TD>
    </TR>
    </TABLE>

    <xsl:variable name="containerName" select="local-name()"/>
    <xsl:for-each select="$mainTags">
      <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      <!-- Add Landing place for any PLSCOPE derived Call link-->
      <xsl:if test="PLSCOPE/@plscopeSignature" >
      <xsl:comment>plscopeSignatureLandingLink</xsl:comment>
      <xsl:element name="A"><xsl:attribute name="NAME"><xsl:value-of select="PLSCOPE/@plscopeSignature" /></xsl:attribute></xsl:element> 
      </xsl:if>
      <xsl:element name="A"><xsl:attribute name="NAME"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)" />
        <xsl:if test="*[name()=$childTags]">
        <xsl:text>(</xsl:text>
        <xsl:for-each select="*[name()=$childTags]">
          <xsl:value-of select="translate(@TYPE, $namesFromCase, $namesToCase)" />
          <xsl:if test="not(position()=last())"><xsl:text>,</xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text>)</xsl:text>
        </xsl:if>
        </xsl:attribute></xsl:element>
      <H3><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></H3>
      <PRE>
        <xsl:variable name="methodText">
		<xsl:if test="not($flagTrigger or $containerName = 'TRIGGER' or $containerName = 'PACKAGE_BODY' or $containerName = 'OBJECT_BODY' )">public</xsl:if><xsl:text> </xsl:text><xsl:value-of select="RETURN/@TYPE"/><xsl:text> </xsl:text><B><xsl:value-of select="@NAME"/></B>
        </xsl:variable>
        <xsl:variable name="methodTextString" select="java:lang.String.new($methodText)"/>
	<xsl:if test="not($flagTrigger or $containerName = 'TRIGGER' or $containerName = 'PACKAGE_BODY' or $containerName = 'OBJECT_BODY' )">public</xsl:if><xsl:text> </xsl:text>
      <!-- 20110428 <xsl:value-of select="RETURN/@TYPE"/> -->
      <!-- If possible, convert the plain-text TYPE to a link to a matching OBJECT TYPE in the Application-->
      <xsl:variable name="fieldType" select="translate(RETURN/@TYPE, $uppercase, $lowercase)" />
      <xsl:call-template name="GenerateTypeLink">
	    <xsl:with-param name="typeName" select="RETURN/@TYPE" />
            <xsl:with-param name="schemaName" select="ancestor-or-self::*/@SCHEMA"/>
            <xsl:with-param name="localTypeName" select="../TYPE[ translate(@NAME, $uppercase, $lowercase) = $fieldType ]/@NAME " />
      </xsl:call-template><xsl:text> </xsl:text><B><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></B>
          <xsl:if test="not($flagTrigger)">
	        <xsl:text>(</xsl:text>
	        <xsl:for-each select="*[name()=$childTags]">
	          <!-- pad arguments with appropriate number of spaces -->
	          <xsl:if test="not(position()=1)"><BR/><xsl:value-of select="str:padding(java:length($methodTextString)+1)"/></xsl:if>
	          <xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
	          <xsl:if test="string-length(@MODE) &gt; 0">
	            <xsl:text> </xsl:text><xsl:value-of select="@MODE"/>
	          </xsl:if>
	          <xsl:text> </xsl:text><xsl:value-of select="@TYPE"/>
	          <xsl:if test="string-length(@DEFAULT) &gt; 0">
	            <xsl:text> DEFAULT </xsl:text><xsl:value-of select="@DEFAULT"/>
	          </xsl:if>
	          <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	        </xsl:for-each>
	        <xsl:text>)</xsl:text>
          </xsl:if>
      </PRE>
      
      <DL>

      <DD>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" >
	      <xsl:call-template name="string-replace-all">
		<xsl:with-param name="text" select="." />
		<xsl:with-param name="replace" select="'@deprecated'"  />
		<xsl:with-param name="by" select = "$boldDeprecated" />
	      </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </DD>

      <DD><DL>
        <xsl:if test="*[name()=$childTags][COMMENT]">
        <DT><xsl:value-of select="$childDescription"/>:
        <xsl:for-each select="*[name()=$childTags]">
          <xsl:if test="COMMENT">
            <DD><CODE><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></CODE> -
              <xsl:for-each select="COMMENT">
                <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
                <xsl:call-template name="processInlineTag">
		    <xsl:with-param name="comment" >
			<xsl:call-template name="string-replace-all">
			  <xsl:with-param name="text" select="." />
			  <xsl:with-param name="replace" select="'@deprecated'"  />
			  <xsl:with-param name="by" select = "$boldDeprecated" />
			</xsl:call-template>
		    </xsl:with-param>
                  <xsl:with-param name="tag" select="'link'" />
                </xsl:call-template>
              </xsl:for-each>
            </DD>
          </xsl:if>
        </xsl:for-each>
        </DT>
        </xsl:if>
        <xsl:for-each select="RETURN/COMMENT">
        <DT>Returns:
          <DD>
            <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
            <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" >
		  <xsl:call-template name="string-replace-all">
		    <xsl:with-param name="text" select="." />
		    <xsl:with-param name="replace" select="'@deprecated'"  />
		    <xsl:with-param name="by" select = "$boldDeprecated" />
		  </xsl:call-template>
            </xsl:with-param>
              <xsl:with-param name="tag" select="'link'" />
            </xsl:call-template>
          </DD>
        </DT>
        </xsl:for-each>
        <xsl:if test="THROWS">
        <DT>Throws:
        <xsl:for-each select="THROWS">
          <DD><CODE><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></CODE> -
              <xsl:for-each select="COMMENT">
                <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
                <xsl:call-template name="processInlineTag">
                  <xsl:with-param name="comment" select="." />
                  <xsl:with-param name="tag" select="'link'" />
                </xsl:call-template>
              </xsl:for-each>
            </DD>
        </xsl:for-each>
        </DT>
        </xsl:if>

		  <!-- triggers only -->
	      <xsl:if test="DECLARATION">
			<DT>Declaration:</DT>
	        <DD>
	          <xsl:value-of select="DECLARATION/@TEXT" disable-output-escaping="yes" />
	        </DD>
	      </xsl:if>
        
    </DL></DD>

	<!-- print custom tags --> 
	<P/>   
    <xsl:call-template name="CustomTagsTemplate"/>
    
    </DL>

        <xsl:if test="PLSCOPE/CALLERS/CALLER[ @SCHEMA != 'SYS' ] ">
        <BR/><DT>Called By:
        <xsl:for-each select="PLSCOPE/CALLERS/CALLER[@SCHEMA != 'SYS' ]">
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	  <xsl:variable name="targetPage"><xsl:choose>
	     <xsl:when test="@OBJECT_TYPE = 'FUNCTION' or @OBJECT_TYPE = 'PROCEDURE' or @OBJECT_TYPE = 'TRIGGER' "><xsl:value-of select="concat('../', $thisSchema, '/', '_', translate(@SCHEMA, $namesFromCase,$namesToCase))" /></xsl:when>
	     <xsl:otherwise><xsl:value-of select="concat('../', $thisSchema, '/', '_',translate(@OBJECT_NAME, $namesFromCase, $namesToCase) ,'_body')" /></xsl:otherwise>
            </xsl:choose></xsl:variable>
	  <BR/>
          <xsl:element name="A"><xsl:attribute name="HREF"><xsl:value-of select="concat($targetPage,'.html#', @CALLING_METHOD_SIGNATURE)" /></xsl:attribute>
          <CODE><xsl:value-of select="concat( translate(@SCHEMA, $namesFromCase, $namesToCase), '.',  translate(@OBJECT_NAME, $namesFromCase, $namesToCase), '.',  translate(@NAME, $namesFromCase, $namesToCase) ) "/></CODE></xsl:element>
	  <xsl:if test="$sourceRootFolder != '' ">
	    &nbsp; 
	      <xsl:call-template name="generate-database-source-link">
		<xsl:with-param name="sourceRootPath" select="$sourceRootFolder" />
		<xsl:with-param name="schema" select="@SCHEMA" />
		<xsl:with-param name="objectType" select="@OBJECT_TYPE" />
		<xsl:with-param name="objectName" select="@OBJECT_NAME" />
		<xsl:with-param name="lineNumber" select="@CALLING_LINE" />
		<xsl:with-param name="linkContents"><i>Call</i></xsl:with-param>
	      </xsl:call-template>
	  </xsl:if>
        </xsl:for-each>
        </DT>
        </xsl:if>
        <xsl:if test="PLSCOPE/CALLEES/CALLEE[@SCHEMA != 'SYS' ]">
        <BR/><DT>Calls:
        <xsl:for-each select="PLSCOPE/CALLEES/CALLEE[@SCHEMA != 'SYS' ]">
      <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>
	  <xsl:variable name="targetPage"><xsl:choose>
	     <xsl:when test="@OBJECT_TYPE = 'FUNCTION' or @OBJECT_TYPE = 'PROCEDURE' or @OBJECT_TYPE = 'TRIGGER' "><xsl:value-of select="concat('../', $thisSchema, '/', '_', translate(@SCHEMA, $namesFromCase,$namesToCase))" /></xsl:when>
	     <xsl:otherwise><xsl:value-of select="concat('../', $thisSchema, '/', '_',translate(@OBJECT_NAME, $namesFromCase, $namesToCase) ,'_body')" /></xsl:otherwise>
            </xsl:choose></xsl:variable>
	  <BR/>
          <xsl:element name="A"><xsl:attribute name="HREF"><xsl:value-of select="concat($targetPage,'.html#', @METHOD_SIGNATURE)" /></xsl:attribute>
          <CODE><xsl:value-of select="translate(@SCHEMA, $namesFromCase, $namesToCase)"/>.<xsl:choose>
	     <xsl:when test="@OBJECT_TYPE = 'FUNCTION' or @OBJECT_TYPE = 'PROCEDURE' "><xsl:value-of select="concat('_', translate(@SCHEMA, $namesFromCase,$namesToCase))" /></xsl:when>
	     <xsl:otherwise><xsl:value-of select="translate(@OBJECT_NAME, $namesFromCase, $namesToCase)" /></xsl:otherwise>
             </xsl:choose>.<xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></CODE></xsl:element>
	  <xsl:if test="$sourceRootFolder!= '' ">
	    &nbsp;
	      <xsl:call-template name="generate-database-source-link">
		<xsl:with-param name="sourceRootPath" select="$sourceRootFolder" />
		<xsl:with-param name="schema" select="@SCHEMA" />
		<xsl:with-param name="objectType" select="@OBJECT_TYPE" />
		<xsl:with-param name="objectName" select="@OBJECT_NAME" />
		<xsl:with-param name="lineNumber" select="@CALLED_LINE" />
		<xsl:with-param name="linkContents"><i>Call</i></xsl:with-param>
	      </xsl:call-template>
	  </xsl:if>
        </xsl:for-each>
        </DT>
        </xsl:if>
    <HR/>
    </xsl:for-each>

    </xsl:if>
  </xsl:template>

  <!-- ************************* START OF PAGE ***************************** -->
  <xsl:template match="/APPLICATION">
  <!-- ********************* START OF top-level object PAGE ************************* -->
  <!--<xsl:for-each select="PACKAGE | PACKAGE_BODY">-->
  <xsl:for-each select="PACKAGE | OBJECT_TYPE | TRIGGER | JAVA[@TYPE='SOURCE'] ">
  <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>

    <redirect:write file="{concat($targetFolder, $thisSchema, '/', translate(@NAME, $namesFromCase, $namesToCase))}.html">


    <HTML>
    <HEAD>
      <TITLE><xsl:value-of select="translate(../@NAME, $namesFromCase, $namesToCase)"/></TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="../stylesheet.css" TITLE="Style"/>
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

    <!-- ********************** PACKAGE DESCRIPTION ************************* -->
    <H2>
    <FONT SIZE="-1"><xsl:value-of select="@SCHEMA"/></FONT><BR/>
     <xsl:choose>
	     <xsl:when test="local-name() = 'OBJECT_TYPE'">
	     <xsl:choose>
		     <xsl:when test="./COLLECTIONTYPE">Object Collection</xsl:when>
		     <xsl:when test="./SUPERTYPE">Subtype</xsl:when>
		     <xsl:otherwise>Object Type</xsl:otherwise>
	      </xsl:choose>
	     </xsl:when>
	      <xsl:when test="local-name() = 'JAVA'">Java</xsl:when>
	      <xsl:otherwise>Package</xsl:otherwise>
     </xsl:choose><xsl:text>&nbsp;</xsl:text><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
    </H2>

	<!-- package comment -->
    <xsl:for-each select="COMMENT">
      <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
      <xsl:call-template name="processInlineTag">
        <xsl:with-param name="comment" select="." />
        <xsl:with-param name="tag" select="'link'" />
      </xsl:call-template>
    </xsl:for-each>

	<P/>
	
	<!-- print custom tags -->    
    <xsl:call-template name="CustomTagsTemplate"/>

    <HR/>
    <P/>

    <!-- ************************** FIELD SUMMARY ************************** -->
    <A NAME="field_summary"></A>
    <xsl:if test="CONSTANT | VARIABLE | SUPERTYPE">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="2"><FONT SIZE="+2">
    <B>Field Summary</B></FONT></TD>
    </TR>

    <xsl:for-each select="CONSTANT | VARIABLE | SUPERTYPE">
      <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      <TR CLASS="TableRowColor">
      <TD ALIGN="right" VALIGN="top" WIDTH="1%"><FONT SIZE="-1">
      <CODE><xsl:text>&nbsp;</xsl:text>
      <!-- If possible, convert the plain-text NAME to a link to a matching OBJECT TYPE in the Application-->
      <xsl:choose>
	      <xsl:when test="local-name() = 'SUPERTYPE'">
		      <!--<xsl:when test="local-name() = 'SUPERTYPE' and /APPLICATION/OBJECT_TYPE[@NAME=./@NAME] ">
	    <A>
		<xsl:attribute name="href"><xsl:value-of select="translate(@NAME, $uppercase, $lowercase)" disable-output-escaping="yes"/>.html</xsl:attribute>
		<xsl:value-of select="@NAME" disable-output-escaping="yes"/>
            </A>
	      <!- - If possible, convert the plain-text TYPE to a link to a matching OBJECT TYPE in the Application-->
	        <xsl:variable name="fieldType" select="translate(@NAME, $namesFromCase, $namesToCase)" />
	      <xsl:call-template name="GenerateTypeLink">
	        <xsl:with-param name="typeName" select="translate(@NAME, $namesFromCase, $namesToCase)" />
		    <xsl:with-param name="schemaName" select="ancestor-or-self::*/@SCHEMA"/>
                    <xsl:with-param name="localTypeName" select="../TYPE[ translate(@NAME, $uppercase, $lowercase) = $fieldType ]/@NAME " />
	      </xsl:call-template>
       </xsl:when>
	  <xsl:otherwise>
	    <xsl:variable name="fieldType" select="translate(RETURN/@TYPE, $uppercase, $lowercase)" />
	      <xsl:call-template name="GenerateTypeLink">
		    <xsl:with-param name="typeName" select="RETURN/@TYPE" />
		    <xsl:with-param name="schemaName" select="ancestor-or-self::*/@SCHEMA"/>
                    <xsl:with-param name="localTypeName" select="../TYPE[ translate(@NAME, $uppercase, $lowercase) = $fieldType ]/@NAME " />
	      </xsl:call-template>
	  </xsl:otherwise>
      </xsl:choose>
      </CODE></FONT></TD>
      <TD><CODE>
      <xsl:choose>
	  <xsl:when test="local-name() = 'SUPERTYPE'">SUPERTYPE</xsl:when>
	  <xsl:otherwise>
	    <B><A HREF="#{translate(@NAME, $namesFromCase, $namesToCase)}"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></A></B>
	  </xsl:otherwise>
      </xsl:choose>
	 <xsl:if test="local-name() = 'CONSTANT'"> CONSTANT</xsl:if>
	 <xsl:if test="@DEFAULT"> := <xsl:value-of select="@DEFAULT" disable-output-escaping="yes" /></xsl:if>
        </CODE>
      <BR/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <xsl:if test="not(./TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ])">
        <xsl:for-each select="COMMENT_FIRST_LINE">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" >
		  <xsl:call-template name="string-replace-all">
		    <xsl:with-param name="text" select="." />
		    <xsl:with-param name="replace" select="'@deprecated'"  />
		    <xsl:with-param name="by" select = "$boldDeprecated" />
		  </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
      <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
        <B>Deprecated.</B>&nbsp;<I>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each></I>
      </xsl:for-each>
      </TD>
      </TR>
    </xsl:for-each>

    </TABLE>
    <P/>

    </xsl:if>

    <!-- ************************* TYPE SUMMARY ************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerSummary">
      <xsl:with-param name="fragmentName">type_summary</xsl:with-param>
      <xsl:with-param name="title">Type Summary</xsl:with-param>
      <xsl:with-param name="mainTags" select="TYPE" />
      <xsl:with-param name="childTags" select="'FIELD'" />
    </xsl:call-template>

    <!-- ************************* METHOD SUMMARY ************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerSummary">
      <xsl:with-param name="fragmentName">method_summary</xsl:with-param>
      <xsl:with-param name="title">Method Summary</xsl:with-param>
      <xsl:with-param name="mainTags" select="FUNCTION | PROCEDURE" />
      <xsl:with-param name="childTags" select="'ARGUMENT'" />
    </xsl:call-template>

    <!-- ************************* TRIGGER SUMMARY ************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerSummary">
      <xsl:with-param name="fragmentName">trigger_summary</xsl:with-param>
      <xsl:with-param name="title">Trigger Summary</xsl:with-param>
      <xsl:with-param name="mainTags" select="TRIGGER" />
      <xsl:with-param name="childTags" select="'TIMINGPOINTSECTION'" /> <!-- 11 G Trigger Syntax -->
      <xsl:with-param name="flagTrigger" select="'TRUE'" /> 
    </xsl:call-template>

    <!-- ************************** FIELD DETAIL *************************** -->
    <A NAME="field_detail"></A>
    <xsl:if test="CONSTANT | VARIABLE">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="1"><FONT SIZE="+2">
    <B>Field Detail</B></FONT></TD>
    </TR>
    </TABLE>

    <xsl:for-each select="CONSTANT | VARIABLE">
      <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      <A NAME="{@NAME}"></A><H3><xsl:value-of select="@NAME"/></H3>
      <PRE>
        public <xsl:value-of select="RETURN/@TYPE"/><xsl:text> </xsl:text><B><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></B>
	 <xsl:if test="local-name() = 'CONSTANT'"> CONSTANT</xsl:if>
	 <xsl:if test="@DEFAULT"> := <xsl:value-of select="@DEFAULT" disable-output-escaping="yes" /></xsl:if>
      </PRE>
      <DL>
      <xsl:for-each select="TAG[@TYPE='@deprecated' or @TYPE='@DEPRECATED' ]">
        <DD><B>Deprecated.</B>&nbsp;<I>
          <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
          </xsl:for-each></I>
        </DD><P/>
      </xsl:for-each>
      <DD>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" >
		<xsl:call-template name="string-replace-all">
		  <xsl:with-param name="text" select="." />
		  <xsl:with-param name="replace" select="'@deprecated'"  />
		  <xsl:with-param name="by" select = "$boldDeprecated" />
		 </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </DD>

      <DD><DL>
    </DL>
    </DD>
    </DL>

    <HR/>
    </xsl:for-each>

    </xsl:if>

    <!-- ************************* TYPE DETAIL *************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerDetail">
      <xsl:with-param name="fragmentName">type_detail</xsl:with-param>
      <xsl:with-param name="title">Type Detail</xsl:with-param>
      <xsl:with-param name="mainTags" select="TYPE" />
      <xsl:with-param name="childTags" select="'FIELD'" />
      <xsl:with-param name="childDescription" select="'Parameters'"/>
    </xsl:call-template>

    <!-- ************************* METHOD DETAIL *************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerDetail">
      <xsl:with-param name="fragmentName">method_detail</xsl:with-param>
      <xsl:with-param name="title">Method Detail</xsl:with-param>
      <xsl:with-param name="mainTags" select="FUNCTION | PROCEDURE" />
      <xsl:with-param name="childTags" select="'ARGUMENT'" />
      <xsl:with-param name="childDescription" select="'Parameters'"/>
    </xsl:call-template>

    <!-- ************************* TRIGGER DETAIL *************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerDetail">
      <xsl:with-param name="fragmentName">trigger_detail</xsl:with-param>
      <xsl:with-param name="title">Trigger Detail</xsl:with-param>
      <xsl:with-param name="mainTags" select="TRIGGER" />
      <xsl:with-param name="childTags" select="'TIMINGPOINTSECTION'" />
      <xsl:with-param name="flagTrigger" select="'TRUE'" /> 
      <xsl:with-param name="childDescription" select="'Timing Points'"/>
    </xsl:call-template>

    <!-- ***************************** FOOTER ****************************** -->
    <xsl:call-template name="NavigationBar"/>

    </BODY>
    </HTML>

    </redirect:write>
  </xsl:for-each> <!-- select="PACKAGE | PACKAGE_BODY" -->

  <!--<xsl:for-each BODY object">
    This is cut and paste of the callable Oracle Object XSLT with the exception of the output file name  
  -->
  <xsl:for-each select="PACKAGE_BODY | OBJECT_BODY | */TRIGGER[@TYPE='COMPOUND'] ">
    <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>

    <redirect:write file="{concat($targetFolder, $thisSchema, '/',  '_', translate(@NAME, $namesFromCase, $namesToCase))}_body.html">

    <HTML>
    <HEAD>
      <TITLE><xsl:value-of select="translate(../@NAME, $namesFromCase, $namesToCase)"/></TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="../stylesheet.css" TITLE="Style"/>
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

    <!-- ********************** PACKAGE DESCRIPTION ************************* -->
    <H2>
    <FONT SIZE="-1"><xsl:value-of select="@SCHEMA"/></FONT><BR/>
     <xsl:choose>
	     <xsl:when test="local-name() = 'OBJECT_BODY'">
	     <xsl:choose>
		     <xsl:when test="./COLLECTIONTYPE">Object Collection</xsl:when>
		     <xsl:when test="./SUPERTYPE">Subtype</xsl:when>
		     <xsl:otherwise>Object Type</xsl:otherwise>
	      </xsl:choose>
	     </xsl:when>
	     <xsl:when test="local-name() = 'TRIGGER'">Trigger</xsl:when>
	     <xsl:when test="local-name() = 'JAVA'">Java</xsl:when>
	     <xsl:otherwise>Package</xsl:otherwise>
     </xsl:choose><xsl:text>&nbsp;</xsl:text><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
    </H2>

	<!-- package comment -->
    <xsl:for-each select="COMMENT">
      <!-- SRT 20110501 <xsl:value-of select="." disable-output-escaping="yes" /> -->
      <xsl:call-template name="processInlineTag">
        <xsl:with-param name="comment" select="." />
        <xsl:with-param name="tag" select="'link'" />
      </xsl:call-template>
    </xsl:for-each>

	<P/>
	
	<!-- print custom tags -->    
    <xsl:call-template name="CustomTagsTemplate"/>

    <HR/>
    <P/>

    <!-- ************************** FIELD SUMMARY ************************** -->
    <A NAME="field_summary"></A>
    <xsl:if test="CONSTANT | VARIABLE | SUPERTYPE">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="2"><FONT SIZE="+2">
    <B>Field Summary</B></FONT></TD>
    </TR>

    <xsl:for-each select="CONSTANT | VARIABLE | SUPERTYPE">
      <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      <TR CLASS="TableRowColor">
      <TD ALIGN="right" VALIGN="top" WIDTH="1%"><FONT SIZE="-1">
      <CODE><xsl:text>&nbsp;</xsl:text>
      <!-- If possible, convert the plain-text NAME to a link to a matching OBJECT TYPE in the Application-->
      <xsl:choose>
	      <xsl:when test="local-name() = 'SUPERTYPE'">
		      <!--<xsl:when test="local-name() = 'SUPERTYPE' and /APPLICATION/OBJECT_TYPE[@NAME=./@NAME] ">
	    <A>
		<xsl:attribute name="href"><xsl:value-of select="translate(@NAME, $uppercase, $lowercase)" disable-output-escaping="yes"/>.html</xsl:attribute>
		<xsl:value-of select="@NAME" disable-output-escaping="yes"/>
            </A>
	      <!- - If possible, convert the plain-text TYPE to a link to a matching OBJECT TYPE in the Application-->
	        <xsl:variable name="fieldType" select="translate(@NAME, $namesFromCase, $namesToCase)" />
	      <xsl:call-template name="GenerateTypeLink">
	        <xsl:with-param name="typeName" select="translate(@NAME, $namesFromCase, $namesToCase)" />
		    <xsl:with-param name="schemaName" select="ancestor-or-self::*/@SCHEMA"/>
	        <xsl:with-param name="localTypeName" select="../TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = $fieldType ]/@NAME " />
	      </xsl:call-template>
       </xsl:when>
	  <xsl:otherwise>
	    <xsl:variable name="fieldType" select="translate(RETURN/@TYPE, $namesFromCase, $namesToCase)" />
	      <xsl:call-template name="GenerateTypeLink">
		    <xsl:with-param name="typeName" select="RETURN/@TYPE" />
		    <xsl:with-param name="schemaName" select="ancestor-or-self::*/@SCHEMA"/>
	        <xsl:with-param name="localTypeName" select="../TYPE[ translate(@NAME, $namesFromCase, $namesToCase) = $fieldType ]/@NAME " />
	      </xsl:call-template>
	  </xsl:otherwise>
      </xsl:choose>
      </CODE></FONT></TD>
      <TD><CODE>
      <xsl:choose>
	  <xsl:when test="local-name() = 'SUPERTYPE'">SUPERTYPE</xsl:when>
	  <xsl:otherwise>
	    <B><A HREF="#{translate(@NAME, $namesFromCase, $namesToCase)}"><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></A></B>
	  </xsl:otherwise>
      </xsl:choose>
	 <xsl:if test="local-name() = 'CONSTANT'"> CONSTANT</xsl:if>
	 <xsl:if test="@DEFAULT"> := <xsl:value-of select="@DEFAULT" disable-output-escaping="yes" /></xsl:if>
        </CODE>
      <BR/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <xsl:if test="not(./TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ])">
        <xsl:for-each select="COMMENT_FIRST_LINE">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
      <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
        <B>Deprecated.</B>&nbsp;<I>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each></I>
      </xsl:for-each>
      </TD>
      </TR>
    </xsl:for-each>

    </TABLE>
    <P/>

    </xsl:if>

    <!-- ************************* TYPE SUMMARY ************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerSummary">
      <xsl:with-param name="fragmentName">type_summary</xsl:with-param>
      <xsl:with-param name="title">Type Summary</xsl:with-param>
      <xsl:with-param name="mainTags" select="TYPE" />
      <xsl:with-param name="childTags" select="'FIELD'" />
    </xsl:call-template>

    <!-- ************************* METHOD SUMMARY ************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerSummary">
      <xsl:with-param name="fragmentName">method_summary</xsl:with-param>
      <xsl:with-param name="title">Method Summary</xsl:with-param>
      <xsl:with-param name="mainTags" select="FUNCTION | PROCEDURE" />
      <xsl:with-param name="childTags" select="'ARGUMENT'" />
    </xsl:call-template>

    <!-- ************************* TRIGGER SUMMARY ************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerSummary">
      <xsl:with-param name="fragmentName">trigger_summary</xsl:with-param>
      <xsl:with-param name="title">Trigger Summary</xsl:with-param>
      <xsl:with-param name="mainTags" select="TRIGGER" />
      <xsl:with-param name="childTags" select="'TIMINGPOINTSECTION'" /> <!-- 11 G Trigger Syntax -->
      <xsl:with-param name="flagTrigger" select="'TRUE'" /> 
    </xsl:call-template>

    <!-- Cope with Compound Triggers treated as package bodies -->
      <xsl:if test="local-name() = 'TRIGGER'">
	<xsl:call-template name="MethodOrTypeOrTriggerSummary">
	  <xsl:with-param name="fragmentName">trigger_summary</xsl:with-param>
	  <xsl:with-param name="title">Timing Summary</xsl:with-param>
	  <xsl:with-param name="mainTags" select="TIMINGPOINTSECTION" />
	  <xsl:with-param name="childTags" select="'NOTHING'" /> <!-- 11 G Trigger Syntax -->
	  <xsl:with-param name="flagTrigger" select="'TRUE'" /> 
	</xsl:call-template>
      </xsl:if>
    <!-- ************************** FIELD DETAIL *************************** -->
    <A NAME="field_detail"></A>
    <xsl:if test="CONSTANT | VARIABLE">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="1"><FONT SIZE="+2">
    <B>Field Detail</B></FONT></TD>
    </TR>
    </TABLE>

    <xsl:for-each select="CONSTANT | VARIABLE">
      <xsl:sort select="translate(@NAME, $namesFromCase, $namesToCase)"/>
      <A NAME="{translate(@NAME, $namesFromCase, $namesToCase)}"></A><H3><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></H3>
      <PRE>
        public <xsl:value-of select="RETURN/@TYPE"/><xsl:text> </xsl:text><B><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></B>
	 <xsl:if test="local-name() = 'CONSTANT'"> CONSTANT</xsl:if>
	 <xsl:if test="@DEFAULT"> := <xsl:value-of select="@DEFAULT" disable-output-escaping="yes" /></xsl:if>
      </PRE>
      <DL>
      <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
        <DD><B>Deprecated.</B>&nbsp;<I>
          <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
          </xsl:for-each></I>
        </DD><P/>
      </xsl:for-each>
      <DD>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </DD>

      <DD><DL>
    </DL>
    </DD>
    </DL>

    <HR/>
    </xsl:for-each>

    </xsl:if>

    <!-- ************************* TYPE DETAIL *************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerDetail">
      <xsl:with-param name="fragmentName">type_detail</xsl:with-param>
      <xsl:with-param name="title">Type Detail</xsl:with-param>
      <xsl:with-param name="mainTags" select="TYPE" />
      <xsl:with-param name="childTags" select="'FIELD'" />
      <xsl:with-param name="childDescription" select="'Parameters'"/>
    </xsl:call-template>

    <!-- ************************* METHOD DETAIL *************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerDetail">
      <xsl:with-param name="fragmentName">method_detail</xsl:with-param>
      <xsl:with-param name="title">Method Detail</xsl:with-param>
      <xsl:with-param name="mainTags" select="FUNCTION | PROCEDURE" />
      <xsl:with-param name="childTags" select="'ARGUMENT'" />
      <xsl:with-param name="childDescription" select="'Parameters'"/>
    </xsl:call-template>

    <!-- ************************* TRIGGER DETAIL *************************** -->
    <xsl:call-template name="MethodOrTypeOrTriggerDetail">
      <xsl:with-param name="fragmentName">trigger_detail</xsl:with-param>
      <xsl:with-param name="title">Trigger Detail</xsl:with-param>
      <xsl:with-param name="mainTags" select="TRIGGER" />
      <xsl:with-param name="childTags" select="'TIMINGPOINTSECTION'" />
      <xsl:with-param name="flagTrigger" select="'TRUE'" /> 
      <xsl:with-param name="childDescription" select="'Timing Points'"/>
    </xsl:call-template>

    <!-- Cope with Compound Triggers treated as package bodies -->
      <xsl:if test="local-name() = 'TRIGGER'">
	<xsl:call-template name="MethodOrTypeOrTriggerDetail">
	  <xsl:with-param name="fragmentName">trigger_detail</xsl:with-param>
	  <xsl:with-param name="title">Timing Detail</xsl:with-param>
	  <xsl:with-param name="mainTags" select="TIMINGPOINTSECTION" />
	  <xsl:with-param name="childTags" select="'NOTHING'" /> <!-- 11 G Trigger Syntax -->
	  <xsl:with-param name="flagTrigger" select="'TRUE'" /> 
      <xsl:with-param name="childDescription" select="'Timing Points'"/>
	</xsl:call-template>
      </xsl:if>
    <!-- ***************************** FOOTER ****************************** -->
    <xsl:call-template name="NavigationBar"/>

    </BODY>
    </HTML>

    </redirect:write>
  </xsl:for-each> <!-- select="PACKAGE | PACKAGE_BODY" -->

  <!--<xsl:for-each BODY">-->

  <!-- ********************** START OF TABLE PAGE ************************** -->
  <xsl:for-each select="TABLE | VIEW">
    <xsl:variable name="thisSchema"><xsl:choose> <xsl:when test="string-length(@SCHEMA) &gt; 0 " ><xsl:value-of select="@SCHEMA" /></xsl:when><xsl:otherwise><xsl:value-of select="$defaultSchema" /></xsl:otherwise></xsl:choose></xsl:variable>

    <redirect:write file="{concat($targetFolder, $thisSchema, '/', translate(@NAME, $namesFromCase, $namesToCase))}.html">

    <HTML>
    <HEAD>
      <TITLE><xsl:value-of select="translate(../@NAME, $namesFromCase, $namesToCase)"/></TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="../stylesheet.css" TITLE="Style"/>
 
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

    <!-- ********************** TABLE DECRIPTION ************************* -->
    <H2>
    <FONT SIZE="-1"><xsl:value-of select="@SCHEMA"/></FONT><BR/>
      <xsl:value-of select="local-name(.)"/><xsl:text> </xsl:text><xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/>
    </H2>
    <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
      <P>
      <B>Deprecated.</B>&nbsp;<I>
      <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
      </xsl:for-each></I>
      </P>
    </xsl:for-each>
    <P>
    <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
    </xsl:for-each>
    </P>
    <HR/>
    <P/>

    <!-- ***************************** COLUMNS ***************************** -->
    <A NAME="field_summary"></A>
    <xsl:if test="COLUMN">

    <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
    <TR CLASS="TableHeadingColor">
    <TD COLSPAN="2"><FONT SIZE="+2">
    <B>Columns</B></FONT></TD>
    </TR>

    <xsl:for-each select="COLUMN">
      <TR CLASS="TableRowColor">
      <TD ALIGN="right" VALIGN="top" WIDTH="1%"><FONT SIZE="-1">
      <CODE><xsl:text>&nbsp;</xsl:text>
      <xsl:value-of select="@TYPE"/>
      </CODE></FONT></TD>
        <TD><CODE><B><A HREF="#{translate(@NAME, $namesFromCase, $namesToCase)}">
          <xsl:value-of select="translate(@NAME, $namesFromCase, $namesToCase)"/></A></B>
        </CODE>
      <BR/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <xsl:if test="not(./TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ])">
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
      <xsl:for-each select="TAG[starts-with(@TYPE,'@deprecated') or starts-with(@TYPE,'@DEPRECATED') ]">
        <B>Deprecated.</B>&nbsp;<I>
        <xsl:for-each select="COMMENT">
          <!-- SRT 20110509 <xsl:value-of select="." disable-output-escaping="yes" /> -->
          <xsl:call-template name="processInlineTag">
            <xsl:with-param name="comment" select="." />
            <xsl:with-param name="tag" select="'link'" />
          </xsl:call-template>
        </xsl:for-each></I>
      </xsl:for-each>
      </TD>
      </TR>
    </xsl:for-each>

    </TABLE>
    <P/>

    </xsl:if>

    <!-- ***************************** FOOTER ****************************** -->
    <xsl:call-template name="NavigationBar"/>

    </BODY>
    </HTML>

    </redirect:write>
  </xsl:for-each> <!-- select="TABLE" -->

  </xsl:template>

</xsl:stylesheet>
