<!-- Start of common.xsl -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  extension-element-prefixes="str java"
  exclude-result-prefixes="java"
  >

  <xsl:variable name="uppercase">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
  <xsl:variable name="lowercase">abcdefghijklmnopqrstuvwxyz</xsl:variable>
  <xsl:variable name="defaultSchema">Undefined</xsl:variable>

  <xsl:variable name="boldDeprecated"><b>Deprecated</b></xsl:variable>	
	
	<!-- Issue 3477662 -->
	<xsl:variable name="samecase">ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="namesLowerCase" select="/APPLICATION/GENERATOR/SETTINGS/@NAMES_TO_LOWER_CASE" />
	<xsl:variable name="namesUpperCase" select="/APPLICATION/GENERATOR/SETTINGS/@NAMES_TO_UPPER_CASE" />
	<xsl:variable name="namesDefaultCase" select="/APPLICATION/GENERATOR/SETTINGS/@NAMES_TO_DEFAULT_CASE" />
	<xsl:variable name="defaultNamesCase" select="/APPLICATION/GENERATOR/SETTINGS/@DEFAULT_NAMES_CASE" />
	<xsl:variable name="namesFromCase" >
		<xsl:choose>
			<xsl:when test="$namesLowerCase='TRUE'" >
				<xsl:value-of select="$uppercase" />
			</xsl:when>
			<xsl:when test="$namesUpperCase='TRUE'" >
				<xsl:value-of select="$lowercase" />
			</xsl:when>
			<xsl:when test="$namesDefaultCase='TRUE'" >
				<xsl:value-of select="$samecase" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$samecase" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="namesToCase" >
		<xsl:choose>
			<xsl:when test="$namesLowerCase='TRUE'" >
				<xsl:value-of select="$lowercase" />
			</xsl:when>
			<xsl:when test="$namesUpperCase='TRUE'" >
				<xsl:value-of select="$uppercase" />
			</xsl:when>
			<xsl:when test="$namesDefaultCase='TRUE'" >
				<xsl:value-of select="$samecase" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$samecase" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- Issue 3477662 -->
	
	<!-- ***************** string-replace-all - perform case insensitive replace ****************** -->
	<xsl:template name="string-replace-all">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="by"/>
		<xsl:variable name="lowerCaseText" select="translate($text, $uppercase, $lowercase)" />
		<xsl:variable name="lowerCaseReplace" select="translate($replace, $uppercase, $lowercase)" />
		<xsl:choose>
			<xsl:when test="contains($lowerCaseText,$lowerCaseReplace)">
				<xsl:variable name="preMatchLength" select="string-length(substring-before($lowerCaseText,$lowerCaseReplace))" />
				<xsl:value-of select="substring($text,1,$preMatchLength)" disable-output-escaping="yes" />
				<xsl:copy-of select="$by" />
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring($text,($preMatchLength + string-length($replace) + 1 ) )"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="by" select="$by"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" disable-output-escaping="yes" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ***************** generate-source-link - generate link to source code assuming standard extract structure -->
	<xsl:template name="generate-database-source-link">
		<xsl:param name="sourceRootPath"/>
		<xsl:param name="schema"/>
		<xsl:param name="objectType"/>
		<xsl:param name="objectName"/>
		<xsl:param name="lineNumber"/>
		<xsl:param name="linkContents"/>
		<xsl:variable name="fileSuffix">
		  <xsl:choose>
		    <xsl:when test="$objectType='PROCEDURE'">prc</xsl:when>
		    <xsl:when test="$objectType='FUNCTION'">fnc</xsl:when>
		    <xsl:when test="$objectType='TRIGGER'">trg</xsl:when>
		    <xsl:when test="$objectType='PACKAGE'">pks</xsl:when>
		    <xsl:when test="$objectType='TYPE'">tps</xsl:when>
		    <xsl:when test="$objectType='PACKAGE BODY'">pkb</xsl:when>
		    <xsl:when test="$objectType='TYPE BODY'">tpb</xsl:when>
		    <xsl:when test="$objectType='JAVA SOURCE'">java</xsl:when>
		    <xsl:otherwise>txt</xsl:otherwise>
		  </xsl:choose>
		</xsl:variable>
		<xsl:variable name="internalLink">
		<xsl:if test="$lineNumber != ''">
		  <xsl:value-of select="concat('#',$lineNumber)" />
		</xsl:if>
		</xsl:variable>
	      <xsl:variable name="hrefSchema"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $schema ))"/></xsl:variable>
	<xsl:element name="A"><xsl:attribute name="HREF"><xsl:value-of select="concat( $sourceRootPath,'/../', $hrefSchema ,'/', translate($objectType, ' ','_') ,'/', $objectName, '.', $fileSuffix, '.xml' ,$internalLink )" /></xsl:attribute><xsl:copy-of select="$linkContents" /></xsl:element>
	</xsl:template>
	
	<!-- End of String Replace -->	
</xsl:stylesheet>
<!-- End of common.xsl -->
	
