<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"><xsl:output method="xml" indent="yes" version="1.1" />

<xsl:param name="plscopeDocument" />
<xsl:param name="pldocDocument" />


<xsl:template match="/APPLICATION">
    <xsl:element name="APPLICATION">
    <!-- Copy any existing attributes before appending input files attributes -->
    <xsl:copy-of select="@*"/>

    <xsl:attribute name="pldocDocument"><xsl:value-of select="$pldocDocument" /></xsl:attribute>
    <xsl:attribute name="plscopeSignatureDocument"><xsl:value-of select="$plscopeDocument" /></xsl:attribute>
    <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<!--specific template match for this img -->
<xsl:template match="FUNCTION | PROCEDURE | TRIGGER ">
    <xsl:variable name="executableID" select="generate-id()" /> 
    <xsl:variable name="pldocOwner" select="../@SCHEMA" /> 
    <xsl:variable name="pldocObjectName" select="../@NAME"/>
    <xsl:variable name="pldocObjectType" select="local-name(..)"/>
    <xsl:variable name="pldocMethodName" select="@NAME"/>
    <xsl:variable name="pldocMethodType" select="local-name()"/>
    <xsl:variable name="pldocMethodStartLine" select="SUMMARY/@START_LINE"/>
    <xsl:variable name="pldocMethodEndLine" select="SUMMARY/@END_LINE"/>

    <xsl:variable name="plscopeCallerObjectType">
    <xsl:choose>
    <!-- Schema-level FUNCTIONs, PROCEDUREs and TRIGGERS are documented in pseudo-package '_${SCHEMA-NAME}' -->
    <xsl:when test="$pldocObjectType = 'PACKAGE' and $pldocObjectName = concat('_',$pldocOwner)" ><xsl:value-of select="$pldocMethodType" /></xsl:when>
    <xsl:otherwise>
      <xsl:choose>
      <xsl:when test="$pldocObjectType = 'PACKAGE_BODY'" >PACKAGE BODY</xsl:when>
      <xsl:when test="$pldocObjectType = 'OBJECT_TYPE'" >TYPE</xsl:when>
      <xsl:when test="$pldocObjectType = 'TYPE_BODY'" >OBJECT BODY</xsl:when>
      <xsl:otherwise><xsl:value-of select="$pldocMethodType" /></xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

    <xsl:variable name="plscopeCallerObjectName">
    <xsl:choose>
    <!-- Schema-level FUNCTIONs, PROCEDUREs and TRIGGERS are documented in pseudo-package '_${SCHEMA-NAME}' -->
    <xsl:when test="$pldocObjectType = 'PACKAGE' and $pldocObjectName = concat('_',$pldocOwner)" ><xsl:value-of select="$pldocMethodName" /></xsl:when>
    <xsl:otherwise><xsl:value-of select="$pldocObjectName" /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>


  <xsl:copy>
    <xsl:apply-templates select="@*|node()" />
      <!-- Retrieve CALLER method name and method type from $plscopeDocument for packages or objects -->
      <xsl:element name="PLSCOPE">
        <xsl:attribute name="pldocID" ><xsl:value-of  select="$executableID" /></xsl:attribute> 
        <xsl:attribute name="pldocOwner" ><xsl:value-of  select="$pldocOwner" /></xsl:attribute> 
        <xsl:attribute name="pldocObjectName" ><xsl:value-of  select="$pldocObjectName" /></xsl:attribute>
        <xsl:attribute name="pldocObjectType" ><xsl:value-of  select="$pldocObjectType" /></xsl:attribute>
        <xsl:attribute name="pldocMethodName" ><xsl:value-of  select="$pldocMethodName" /></xsl:attribute>
        <xsl:attribute name="pldocMethodType" ><xsl:value-of  select="$pldocMethodType" /></xsl:attribute>
        <xsl:attribute name="pldocMethodStartLine" ><xsl:value-of  select="$pldocMethodStartLine" /></xsl:attribute>
        <xsl:attribute name="pldocMethodEndLine" ><xsl:value-of  select="$pldocMethodEndLine" /></xsl:attribute>
        <xsl:attribute name="plscopeCallerObjectType" ><xsl:value-of select="$plscopeCallerObjectType" /></xsl:attribute>
        <xsl:attribute name="plscopeCallerObjectName" ><xsl:value-of select="$plscopeCallerObjectName" /></xsl:attribute>

        <xsl:attribute name="plscopeSignature" ><xsl:choose>
	<!-- When looking for a standalone function or procedure, ignore the line number check - it is unreliable, being dependent on how the CREATE OR REPLACE is fornatted when parsed by PLDoc-->
	<xsl:when test="$plscopeCallerObjectType = 'FUNCTION' or $plscopeCallerObjectType = 'PROCEDURE' or $plscopeCallerObjectType = 'TRIGGER' " ><xsl:value-of select="document($plscopeDocument)/PLSCOPE/IDENTIFIER[ @OWNER = $pldocOwner and @OBJECT_TYPE = $plscopeCallerObjectType  and @OBJECT_NAME = $plscopeCallerObjectName  and @PRIORITY = 1 ]/@SIGNATURE " /></xsl:when> 
	<xsl:otherwise><xsl:value-of select="document($plscopeDocument)/PLSCOPE/IDENTIFIER[ @OWNER = $pldocOwner and @OBJECT_TYPE = $plscopeCallerObjectType  and @OBJECT_NAME = $plscopeCallerObjectName and @LINE >= $pldocMethodStartLine  and $pldocMethodEndLine  >= @LINE  and @PRIORITY = 1 ]/@SIGNATURE " /></xsl:otherwise>
        </xsl:choose></xsl:attribute>
      </xsl:element>
  </xsl:copy>
</xsl:template>

<!--Identity template copies content forward -->
<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>


</xsl:stylesheet>

