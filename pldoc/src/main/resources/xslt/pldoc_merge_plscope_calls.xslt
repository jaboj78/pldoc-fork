<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"><xsl:output method="xml" indent="yes" version="1.1" />

<xsl:param name="plscopeDocument" />
<xsl:param name="pldocDocument" />

<xsl:key name="key_CALLSByCALLEE" match="CALL" use="concat(@CALLED_OWNER , '~',  @CALLED_OBJECT_TYPE , '~',  @CALLED_OBJECT_NAME , '~',  @CALLED_TYPE , '~',  @CALLED_NAME , '~' )"/>

<xsl:key name="key_CALLSByCALLER" match="CALL" use="concat(@CALLER_OWNER , '~',  @CALLER_OBJECT_TYPE , '~',  @CALLER_OBJECT_NAME , '~',  @CALLER_TYPE , '~',  @CALLER_NAME , '~' )"/>

<xsl:template match="/APPLICATION">
    <xsl:element name="APPLICATION">
    <!-- Copy any existing attributes before appending input files attributes -->
    <xsl:copy-of select="@*"/>

    <xsl:attribute name="pldocIntermediateDocument"><xsl:value-of select="$pldocDocument" /></xsl:attribute>
    <xsl:attribute name="plscopeCallDocument"><xsl:value-of select="$plscopeDocument" /></xsl:attribute>
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


  <xsl:copy>
    <xsl:apply-templates select="@*|node()" />
  </xsl:copy>
</xsl:template>

<xsl:template match="PLSCOPE">
    <xsl:element name="PLSCOPE">
    <!-- Copy any existing attributes before appending input files attributes -->
    <xsl:copy-of select="@*"/>

      <!-- Retrieve CALLER method name and method type from $plscopeDocument for packages or objects -->
        <xsl:variable name="pldocID" select="@pldocID" />
        <xsl:variable name="pldocOwner" select="@pldocOwner" />
        <xsl:variable name="pldocObjectName" select="@pldocObjectName" />
        <xsl:variable name="pldocObjectType" select="@pldocObjectType" />
        <xsl:variable name="pldocMethodName" select="@pldocMethodName" />
        <xsl:variable name="pldocMethodType" select="@pldocMethodType" />
        <xsl:variable name="pldocMethodStartLine" select="@pldocMethodStartLine" />
        <xsl:variable name="pldocMethodEndLine" select="@pldocMethodEndLine" />
        <xsl:variable name="plscopeCallerObjectType" select="@plscopeCallerObjectType" />
        <xsl:variable name="plscopeCallerObjectName" select="@plscopeCallerObjectName" />
        <xsl:variable name="plscopeSignature" select="@plscopeSignature" />


        <xsl:element name="CALLERS">
          <!-- xsl:apply-templates select="document($plscopeDocument)/PLSCOPE/CALL[ @CALLED_OWNER = $pldocOwner and @CALLED_OBJECT_TYPE = $plscopeCallerObjectType  and @CALLED_OBJECT_NAME = $pldocObjectName and @CALLED_TYPE = $pldocMethodType  and @CALLED_NAME = $pldocMethodName and not (  preceding-sibling::CALL[ @CALLER_OWNER = ./@CALLER_OWNER  and @CALLER_OBJECT_TYPE = ./@CALLER_OBJECT_TYPE  and @CALLER_OBJECT_NAME = ./@CALLER_OBJECT_NAME and @CALLER_TYPE = ./@CALLER_TYPE and @CALLER_NAME = ./@CALLER_NAME ] )  ] " /-->
          <xsl:apply-templates select="document($plscopeDocument)/PLSCOPE/CALL[ @CALLED_OWNER = $pldocOwner and @CALLED_OBJECT_TYPE = $plscopeCallerObjectType and ( ((@CALLED_OBJECT_TYPE = 'PROCEDURE' or  @CALLED_OBJECT_TYPE = 'FUNCTION') and $pldocObjectName = concat('_',@CALLED_OWNER) ) or (@CALLED_OBJECT_NAME = $pldocObjectName) ) and @CALLED_TYPE = $pldocMethodType  and @CALLED_NAME = $pldocMethodName  ] " />
        </xsl:element>

        <xsl:element name="CALLEES" >
          <!-- Unique callees -->
          <xsl:for-each select="document($plscopeDocument)/PLSCOPE/CALL[ @CALLER_OWNER = $pldocOwner and @CALLER_OBJECT_TYPE = $plscopeCallerObjectType  and @CALLER_OBJECT_NAME = $plscopeCallerObjectName and @CALLER_LINE >= $pldocMethodStartLine  and $pldocMethodEndLine  >= @CALLER_LINE  and not( (preceding-sibling::CALL[ @CALLED_OWNER = ./@CALLED_OWNER ])  and (preceding-sibling::CALL[ @CALLED_OBJECT_TYPE = ./CALLED_OBJECT_TYPE]) and (preceding-sibling::CALL[ @CALLED_OBJECT_NAME = ./@CALLED_OBJECT_NAME]) and (preceding-sibling::CALL[ @CALLED_TYPE = ./@CALLED_TYPE]) and (preceding-sibling::CALL[ @CALLED_NAME = ./@CALLED_NAME]) ) ] " >
            <xsl:element name="CALLEE">
              <xsl:attribute name="SCHEMA"><xsl:value-of select = "@CALLED_OWNER" /></xsl:attribute>
              <xsl:attribute name="OBJECT_TYPE"><xsl:value-of select = "@CALLED_OBJECT_TYPE" /></xsl:attribute>
              <xsl:attribute name="OBJECT_NAME"><xsl:value-of select = "@CALLED_OBJECT_NAME" /></xsl:attribute>
              <xsl:attribute name="NAME"><xsl:value-of select = "@CALLED_NAME" /></xsl:attribute>
              <xsl:attribute name="TYPE"><xsl:value-of select = "@CALLED_TYPE" /></xsl:attribute>
              <xsl:attribute name="CALLED_LINE"><xsl:value-of select = "@CALLED_LINE" /></xsl:attribute>
              <xsl:attribute name="CALLED_COLUMN"><xsl:value-of select = "@CALLED_COL" /></xsl:attribute>
              <xsl:attribute name="CALLING_LINE"><xsl:value-of select = "@CALLER_LINE" /></xsl:attribute>
              <xsl:attribute name="CALLING_COLUMN"><xsl:value-of select = "@CALLER_COL" /></xsl:attribute>

	      <!-- METHOD_SIGNATURE is unique for a PROCEDURE / METHOD -identical for DECLARATION / DEFINITION of a METHOD  
	           We can relate the SCHEMA.OBJECT_TYPE.METHOD_NAME.LINE.COLUMN now in both Application.xml and plscope.xml
		   to the signature to get a unique method signature into the merged application-plsql.xml.

		   Then we can use the method signature as the node id 
	      -->
              <xsl:attribute name="METHOD_SIGNATURE"><xsl:value-of select = "@CALLED_METHOD_SIGNATURE" /></xsl:attribute>
	      <!-- Unique for a CALL -->
              <xsl:attribute name="CALL_HASH"><xsl:value-of select = "@CALL_HASH" /></xsl:attribute>
	      <!-- Unique for a PL/SQL OBJECT -->
              <xsl:attribute name="CALLER_OBJECT_HASH"><xsl:value-of select = "@CALLER_OBJECT_HASH" /></xsl:attribute>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>

    <xsl:apply-templates />
    </xsl:element>
</xsl:template>


<!--Identity template copies content forward -->
<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

<!-- Lookup PLDoc Method Type and Name From PLScope CALL -->
<xsl:template match="CALL">
    <xsl:variable name="callHash" select="@CALL_HASH"/>
    <xsl:variable name="callerObjectHash" select="@CALLER_OBJECT_HASH"/>
    <xsl:variable name="calledMethodSignature" select="@CALLED_METHOD_SIGNATURE"/>
    <xsl:variable name="callerOwner" select="@CALLER_OWNER" /> 
    <xsl:variable name="callerObjectName" select="@CALLER_OBJECT_NAME"/>
    <xsl:variable name="callerObjectType" select="@CALLER_OBJECT_TYPE"/>
    <xsl:variable name="callerObjectLine" select="@CALLER_LINE"/>
    <xsl:variable name="callerObjectColumn" select="@CALLER_COL"/>
    <!--xsl:variable name="callerName" select="COLUMN[@NAME='caller_NAME']/text()"/>
    <xsl:variable name="callerType" select="COLUMN[@NAME='caller_TYPE']/text()"/-->

    <xsl:variable name="calledOwner" select="@CALLED_OWNER" /> 
    <xsl:variable name="calledObjectName" select="@CALLED_OBJECT_NAME"/>
    <xsl:variable name="calledObjectType" select="@CALLED_OBJECT_TYPE"/>
    <xsl:variable name="calledObjectLine" select="@CALLED_LINE"/>
    <xsl:variable name="calledObjectColumn" select="@CALLED_COL"/>
    <xsl:variable name="calledName" select="@CALLED_NAME"/>
    <xsl:variable name="calledType" select="@CALLED_TYPE"/>
    <!-- Map OBJECT_TYPE column from Oracle dictionary to appropriate element name in application.xml  
     PACKAGE | PACKAGE_BODY | OBJECT_TYPE | OBJECT_BODY [ name() = $calledObjectType and  @SCHEMA=$calledOwner and @NAME=$calledObjectName ]/*/[ @START_LINE = $calledObjectLine and @START_COLUMN = $calledObjectColumn ]  -->

    <xsl:variable name="pldocCallerObjectType">
    <xsl:choose>
    <xsl:when test="$callerObjectType = 'PACKAGE BODY'" >PACKAGE_BODY</xsl:when>
    <xsl:when test="$callerObjectType = 'TYPE'" >OBJECT_TYPE</xsl:when>
    <xsl:when test="$callerObjectType = 'TYPE BODY'" >OBJECT_BODY</xsl:when>
    <xsl:otherwise><xsl:value-of select="$callerObjectType" /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>


    <xsl:variable name="pldocCalledObjectType">
    <xsl:choose>
    <xsl:when test="$calledObjectType = 'PACKAGE BODY'" >PACKAGE_BODY</xsl:when>
    <xsl:when test="$calledObjectType = 'TYPE'" >OBJECT_TYPE</xsl:when>
    <xsl:when test="$calledObjectType = 'TYPE BODY'" >OBJECT_BODY</xsl:when>
    <xsl:otherwise><xsl:value-of select="$calledObjectType" /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

    <!-- Retrieve CALLER method name and method type from application.xml for packages or objects -->
    <xsl:variable name="pldocCallerMethodName">
    <xsl:choose>
    <xsl:when test="$callerObjectType = 'FUNCTION' or $callerObjectType = 'PROCEDURE'  or $callerObjectType = 'TRIGGER'  " ><xsl:value-of select="$callerObjectName" /></xsl:when>
    <xsl:otherwise><xsl:value-of select="document($pldocDocument)//*[ local-name(..) = $pldocCallerObjectType and ../@SCHEMA = $callerOwner and ../@NAME = $callerObjectName and $callerObjectLine >=SUMMARY/@START_LINE and SUMMARY/@END_LINE >= $callerObjectLine  ]/@NAME  " /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

    <xsl:variable name="pldocCallerMethodType">
    <xsl:choose>
    <xsl:when test="$callerObjectType = 'FUNCTION' or $callerObjectType = 'PROCEDURE'  or $callerObjectType = 'TRIGGER'  " ><xsl:value-of select="$callerObjectType" /></xsl:when>
    <xsl:otherwise><xsl:value-of select="local-name(document($pldocDocument)//*[ local-name(..) = $pldocCallerObjectType and ../@SCHEMA = $callerOwner and ../@NAME = $callerObjectName and $callerObjectLine >=SUMMARY/@START_LINE and SUMMARY/@END_LINE >= $callerObjectLine  ])  " /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>


    <xsl:variable name="pldocCallerMethodSignature">
    <xsl:choose>
      <!-- Standalone FUNCTIONs, PROCEDUREs and TRIGGERs are collected in the faux-PACKAGE (_NOT_ PACKAGE_BODY!!!) based on the SCHEMA-->
    <xsl:when test="$callerObjectType = 'FUNCTION' or $callerObjectType = 'PROCEDURE'  or $callerObjectType = 'TRIGGER'  " ><xsl:value-of select="document($pldocDocument)//*[ local-name(..) = 'PACKAGE' and ../@SCHEMA = $callerOwner and @NAME = $callerObjectName  ]/PLSCOPE/@plscopeSignature  " /></xsl:when>
    <xsl:otherwise><xsl:value-of select="document($pldocDocument)//*[ local-name(..) = $pldocCallerObjectType and ../@SCHEMA = $callerOwner and ../@NAME = $callerObjectName and $callerObjectLine >=SUMMARY/@START_LINE and SUMMARY/@END_LINE >= $callerObjectLine  ]/PLSCOPE/@plscopeSignature  " /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

    <!-- Retrieve called method name from application.xml for packages or objects -->
    <xsl:variable name="pldocCalledMethodName">
    <xsl:choose>
    <xsl:when test="$calledObjectType = 'FUNCTION' or $calledObjectType = 'PROCEDURE'" ><xsl:value-of select="$calledObjectName" /></xsl:when>
    <xsl:otherwise><xsl:value-of select="document($pldocDocument)//*[ local-name(..) = $pldocCalledObjectType and ../@SCHEMA = $calledOwner and ../@NAME = $calledObjectName and SUMMARY/@START_LINE=$calledObjectLine  ]/@NAME  " /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

    <xsl:variable name="pldocCallerID">
    <xsl:choose>
    <xsl:when test="$callerObjectType = 'FUNCTION' or $callerObjectType = 'PROCEDURE'  or $callerObjectType = 'TRIGGER'  " ><xsl:value-of select="generate-id(//*[ local-name(..) = 'PACKAGE_BODY' and ../@SCHEMA = $callerOwner and ../@NAME = concat('_',$callerOwner) and local-name() = $callerObjectType  and ./@NAME = $callerObjectName ])  " />
</xsl:when>
    <xsl:otherwise><xsl:value-of select="generate-id(//*[ local-name(..) = $pldocCallerObjectType and ../@SCHEMA = $callerOwner and ../@NAME = $callerObjectName and $callerObjectLine >=SUMMARY/@START_LINE and SUMMARY/@END_LINE >= $callerObjectLine  ])  " /></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>

  <xsl:element name="CALLER" >
    <xsl:attribute name="SCHEMA"><xsl:value-of select="$callerOwner" /></xsl:attribute>
    <xsl:attribute name="OBJECT_TYPE"><xsl:value-of select="$callerObjectType"/></xsl:attribute>
    <xsl:attribute name="OBJECT_NAME"><xsl:value-of select="$callerObjectName"/></xsl:attribute>
    <xsl:attribute name="OBJECT_HASH"><xsl:value-of select="$callerObjectHash"/></xsl:attribute>
    <xsl:attribute name="NAME"><xsl:value-of select="$pldocCallerMethodName"/></xsl:attribute>
    <xsl:attribute name="TYPE"><xsl:value-of select="$pldocCallerMethodType"/></xsl:attribute>
    <xsl:attribute name="CALLING_METHOD_SIGNATURE"><xsl:value-of select="$pldocCallerMethodSignature"/></xsl:attribute>
    <xsl:attribute name="CALLING_LINE"><xsl:value-of select = "@CALLER_LINE" /></xsl:attribute>
    <xsl:attribute name="CALLING_COLUMN"><xsl:value-of select = "@CALLER_COL" /></xsl:attribute>
    <xsl:attribute name="CALLED_LINE"><xsl:value-of select = "@CALLED_LINE" /></xsl:attribute>
    <xsl:attribute name="CALLED_COLUMN"><xsl:value-of select = "@CALLED_COL" /></xsl:attribute>
    <xsl:attribute name="CALLING_ID"><xsl:value-of select = "$pldocCallerID" /></xsl:attribute>

    <xsl:attribute name="CALL_HASH"><xsl:value-of select="@CALL_HASH"/></xsl:attribute>
    <xsl:attribute name="CALLED_METHOD_SIGNATURE"><xsl:value-of select="@CALLED_METHOD_SIGNATURE"/></xsl:attribute>
    <!--
     CALLING_ID( generate-id( $callerOwner, $callerObjectType, $caller$ObjectName, $callingLine  ) 
    <xsl:attribute name="LINE"><xsl:value-of select="$callerObjectLine"/></xsl:attribute>
    <xsl:attribute name="COLUMN"><xsl:value-of select="$callerObjectColumn"/></xsl:attribute>
    <xsl:attribute name="pldocCalledObjectType"><xsl:value-of select="$pldocCalledObjectType"/></xsl:attribute>
    <xsl:attribute name="pldocCalledMethodName"><xsl:value-of select="$pldocCalledMethodName"/></xsl:attribute>
    <xsl:attribute name="pldocCallerObjectType"><xsl:value-of select="$pldocCallerObjectType"/></xsl:attribute>
    -->
  </xsl:element>
</xsl:template>



</xsl:stylesheet>

