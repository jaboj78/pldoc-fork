	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
		xmlns:exslt="http://exslt.org/common"
		xmlns:str="http://exslt.org/strings"
		xmlns:lxslt="http://xml.apache.org/xslt"
		xmlns:redirect="http://xml.apache.org/xalan/redirect"
		xmlns:java="http://xml.apache.org/xalan/java"
		extension-element-prefixes="redirect str java exslt"
		exclude-result-prefixes="java"
		>

	<!-- ***************** Link tag to TYPE LINK TEMPLATE ****************** -->
	<!-- If possible, convert the plain-text LINK to a link to a matching PACKAGE or OBJECT TYPE link in the Application -->
	<xsl:template name="LinkTagToLink">
		<xsl:param name="label" />
		<xsl:param name="link" />
		<A>
			<xsl:choose>
				<xsl:when test="starts-with($link, '&lt;') or starts-with($link, 'http://') or starts-with($link, 'https://')"> <!-- External Link pass out unmodified-->
					<xsl:attribute name="href"><xsl:value-of select="$link" disable-output-escaping="yes"/></xsl:attribute>
					<xsl:value-of select="$label" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:when test="starts-with($link, '#')"> <!-- Internal Link -->
					<xsl:attribute name="href"><xsl:value-of select="$link" disable-output-escaping="yes"/></xsl:attribute>
					<xsl:value-of select="$label" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:otherwise> <!-- start looking in the Application -->
					
					<xsl:variable name="schemaName">
						<xsl:choose>
							<!-- two dots means that link is written in PL/SQL way as schema.object.method -->
							<xsl:when test="contains($link, '.') and contains(substring-after($link, '.'),'.')">
								<xsl:value-of select="substring-before($link, '.')" />
							</xsl:when>
							<xsl:when test="contains($link, '.')"> <!--  Link contains schema -->
								<xsl:value-of select="substring-before($link, '.')" />
							</xsl:when>
							<xsl:otherwise>  
								<xsl:value-of select="''" />
							</xsl:otherwise>  
						</xsl:choose>
					</xsl:variable>
				        <xsl:variable name="hrefSchemaName"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $schemaName ))"/></xsl:variable>
					<xsl:variable name="methodName">
						<xsl:choose>
							<!-- two dots means that link is written in PL/SQL way as schema.object.method -->
							<xsl:when test="contains($link, '.') and contains(substring-after($link, '.'),'.')">
								<xsl:value-of select="substring-after(substring-after($link, '.'), '.')" />
							</xsl:when>
							<xsl:when test="contains($link, '#')"> <!--  Link contains method -->
								<xsl:value-of select="substring-after($link, '#')" />
							</xsl:when>
							<xsl:otherwise>  
								<xsl:value-of select="''" />
							</xsl:otherwise>  
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="objectName">
						<!--xsl:value-of select="substring-before(substring-after($link, '.'),'#')" /-->
						<xsl:choose>
							<!-- two dots means that link is written in PL/SQL way as schema.object.method -->
							<xsl:when test="contains($link, '.') and contains(substring-after($link, '.'),'.')">
								<xsl:value-of select="substring-before(substring-after($link, '.'), '.')" />
							</xsl:when>
							<xsl:when test="contains($link, '.') and contains($link, '#')"> <!--  Link contains schema, object and method -->
								<xsl:value-of select="substring-after(substring-before($link, '#'),'.')" />
							</xsl:when>
							<xsl:when test="contains($link, '.')"> <!--  Link contains schema and object  -->
								<xsl:value-of select="substring-after($link,'.')" />
							</xsl:when>
							<xsl:when test="contains($link, '#')"> <!--  Link contains object and method -->
								<xsl:value-of select="substring-before($link, '#')" />
							</xsl:when>
							<xsl:otherwise>  
								<xsl:value-of select="$link" />
							</xsl:otherwise>  
						</xsl:choose>
					</xsl:variable>
					<!--
           <xsl:comment>
            schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
            objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
            methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
          </xsl:comment>
          -->
	  <!-- 
                    <xsl:comment>What is the current SCHEMA?</xsl:comment>
	  -->
                    <xsl:variable name="currentSchemaName" select="ancestor-or-self::*/@SCHEMA" />
		    <xsl:variable name="hrefCurrentSchemaName"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $currentSchemaName ))"/></xsl:variable>
					<xsl:choose>
						
						<xsl:when test="string-length($schemaName) &gt; 0 and string-length($objectName) &gt; 0 and string-length($methodName) &gt; 0 and /APPLICATION/*[ translate(@SCHEMA , $uppercase, $lowercase)= translate($schemaName, $uppercase, $lowercase) and translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase) = translate($methodName , $uppercase, $lowercase)] ">
							<!--
                <xsl:comment>
                  matched Explicit schemaName, objectName and methodName 
                  schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                  objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                  methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
                -->
							<xsl:attribute name="href"><xsl:value-of select="concat('../', translate($hrefSchemaName, $namesFromCase, $namesToCase), '/', translate(concat($objectName,'.html#',$methodName), $namesFromCase, $namesToCase) )" disable-output-escaping="yes"/></xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>

						<xsl:when test="string-length($objectName) &gt; 0 and string-length($methodName) &gt; 0 and /APPLICATION/*[ translate(@SCHEMA , $uppercase, $lowercase)= translate($currentSchemaName, $uppercase, $lowercase) and translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase) = translate($methodName , $uppercase, $lowercase)] ">
							<!--
                <xsl:comment>
                  matched objectName and methodName in CURRENT_SCHEMA
                  schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                  objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                  methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
                -->
							<xsl:attribute name="href"><xsl:value-of select="translate(concat($objectName,'.html#',$methodName), $namesFromCase, $namesToCase)" disable-output-escaping="yes"/></xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>
						

						<!-- Attempt to match assuming that the link has been written as a normal PL/SQL entry (object_name.method_name) rather than object_name#method_name   
            -->
						<xsl:when test="string-length($schemaName) &gt; 0 and string-length($objectName) &gt; 0 and /APPLICATION/*[  translate(@SCHEMA , $uppercase, $lowercase)= translate($currentSchemaName, $uppercase, $lowercase) and translate(@NAME , $uppercase, $lowercase)= translate($schemaName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase)] ">
							<!--
                <xsl:comment>
                matched on schemaName and objectName in CURRENT SCHEMA assuming that the link has been written as a normal PL/SQL entry (object_name.method_name) rather than object_name#method_name 
                schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
              -->
							<xsl:attribute name="href"><xsl:value-of select="translate(concat($hrefSchemaName,'.html#',$objectName), $namesFromCase, $namesToCase)" disable-output-escaping="yes"/></xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>

						<xsl:when test="string-length($objectName) &gt; 0 and /APPLICATION/*[  translate(@SCHEMA , $uppercase, $lowercase)= translate($currentSchemaName, $uppercase, $lowercase) and translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ] ">
							<!--
                <xsl:comment>
                  matched objectName  in CURRENT SCHEMA
                  schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                  objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                  methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
                -->
							<xsl:attribute name="href"><xsl:value-of select="translate($objectName, $namesFromCase, $namesToCase)" disable-output-escaping="yes"/>.html</xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>

						<!-- Not in CURRENT SCHEMA, so must locate one -->
						<xsl:when test="string-length($objectName) &gt; 0 and string-length($methodName) &gt; 0 and /APPLICATION/*[ translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase) = translate($methodName , $uppercase, $lowercase)] ">
							<!--
                <xsl:comment>
                  matched objectName and methodName in OTHER SCHEMA 
                  schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                  objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                  methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
                -->
			    <xsl:variable name="otherSchemaName" select="/APPLICATION/*[ translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase) = translate($methodName , $uppercase, $lowercase)][1]/../@SCHEMA " />
			    <xsl:variable name="hrefOtherSchemaName"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $otherSchemaName ))"/></xsl:variable>
							<xsl:attribute name="href"><xsl:value-of select="concat('../', $hrefOtherSchemaName, '/', translate(concat($objectName,'.html#',$methodName), $namesFromCase, $namesToCase))" disable-output-escaping="yes"/></xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>
						

						<!-- Attempt to match assuming that the link has been written as a normal PL/SQL entry (object_name.method_name) rather than object_name#method_name   
            -->
						<xsl:when test="string-length($schemaName) &gt; 0 and string-length($objectName) &gt; 0 and /APPLICATION/*[ translate(@NAME , $uppercase, $lowercase)= translate($schemaName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase)] ">
							<!--
                <xsl:comment>
                matched on schemaName and objectName assuming that the link has been written as a normal PL/SQL entry (object_name.method_name) rather than object_name#method_name 
                schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
              -->
			    <xsl:variable name="otherSchemaName" select="/APPLICATION/*[ translate(@NAME , $uppercase, $lowercase)= translate($schemaName, $uppercase, $lowercase) ]/*[translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase)][1]/../@SCHEMA " />
			    <xsl:variable name="hrefOtherSchemaName"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $otherSchemaName ))"/></xsl:variable>
							<xsl:attribute name="href"><xsl:value-of select="concat('../', $hrefOtherSchemaName, '/', translate(concat($schemaName,'.html#',$objectName), $namesFromCase, $namesToCase))" disable-output-escaping="yes"/></xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>

						<xsl:when test="string-length($objectName) &gt; 0 and /APPLICATION/*[ translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ] ">
							<!--
                <xsl:comment>
                  matched objectName  
                  schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                  objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                  methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                </xsl:comment>
                -->
                            <xsl:variable name="otherSchemaName" select=" /APPLICATION/*[ translate(@NAME , $uppercase, $lowercase)= translate($objectName, $uppercase, $lowercase) ] [1]/@SCHEMA " />
			    <xsl:variable name="hrefOtherSchemaName"><xsl:value-of select="java:getRawFragment(java:java.net.URI.new( 'file' , 'localhost', null, $otherSchemaName ))"/></xsl:variable>
							<xsl:attribute name="href"><xsl:value-of select="concat('../', $hrefOtherSchemaName, '/', translate($objectName, $namesFromCase, $namesToCase))" disable-output-escaping="yes"/>.html</xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:when>						
						<xsl:otherwise>
							<!--
                <xsl:comment>
                  Failed to match with 
                  schemaName=START<xsl:value-of select="$schemaName" disable-output-escaping="yes"/>END
                  objectName=START<xsl:value-of select="$objectName" disable-output-escaping="yes"/>END
                  methodName=START<xsl:value-of select="$methodName" disable-output-escaping="yes"/>END
                  Assuming page internal link
                </xsl:comment>
                -->
							<xsl:attribute name="href"><xsl:value-of select="translate(concat('#',$link),  $namesFromCase, $namesToCase)" disable-output-escaping="yes"/></xsl:attribute>
							<xsl:value-of select="$label" disable-output-escaping="yes"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</A> 
	</xsl:template>
	<!-- -->	
	
	<!-- ***************** processInlineTag - convert specifed inline tag in this text into HTML links ****************** -->
	<xsl:template name="processInlineTag">
		<xsl:param name="comment" />
		<xsl:param name="tag" />
		<xsl:variable name="tagStart">
			<xsl:value-of select="concat('{@',$tag)" />
		</xsl:variable>
		<!--
    <xsl:comment>
      LOOKING for TAG=<xsl:value-of select="$tag" /> in
      LOOKING for TAGSTART=<xsl:value-of select="$tagStart" /> in
      COMMENT==<xsl:value-of select="$comment" />
      COMMENT-NODES==<xsl:value-of select="count(exslt:node-set($comment))" />
    </xsl:comment>
    -->
		<xsl:choose>
			<xsl:when test="contains($comment, $tagStart )"  >
				<!-- Process the bit before the tag -->
				<!--
        <xsl:comment>
          Bit before linkTag=START<xsl:value-of select="substring-before($comment, $tagStart)" disable-output-escaping="yes"/>END
        </xsl:comment>
        -->
				<xsl:value-of select="substring-before($comment, $tagStart)" disable-output-escaping="yes" />
				<!-- Process the the tag text -->
				<xsl:variable name="linkTag">
					<!-- <xsl:value-of select="substring-after(substring-before($comment, '}' ),$tagStart)" /> -->
					<!-- Trim the tag - also normalises spaces in the string -->
					<xsl:value-of select="normalize-space(substring-after(substring-before($comment, '}' ),$tagStart))" />
				</xsl:variable>
				<!--
        <xsl:comment>
          linkTag=START<xsl:value-of select="$linkTag" />END
        </xsl:comment>
        -->
				<xsl:choose>
					<xsl:when test="contains($linkTag, ' ') "  > <!-- normalize-space(string) $linkTag contains a space -->
						<!--
            <xsl:comment>
              link=START<xsl:value-of select="substring-before($linkTag, ' ')" />END
              label=START<xsl:value-of select="substring-after($linkTag, ' ')" />END
            </xsl:comment>
            -->
						<xsl:call-template name="LinkTagToLink">
							<xsl:with-param name="link" select="substring-before($linkTag, ' ')" />
							<xsl:with-param name="label" select="substring-after($linkTag, ' ')" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise >
						<!--
            <xsl:comment>
              link=START<xsl:value-of select="$linkTag" />END
              label=START<xsl:value-of select="$linkTag" />END
            </xsl:comment>
            -->
						<xsl:call-template name="LinkTagToLink">
							<xsl:with-param name="link" select="$linkTag" />
							<xsl:with-param name="label" select="$linkTag" />
						</xsl:call-template>
					</xsl:otherwise >
				</xsl:choose>
				
				<!-- Recursively call processInlineTag on the bit left over-->
				<!--
        <xsl:comment>
          Bit after linkTag=START<xsl:value-of select="substring-after($comment, '}')" />END
        </xsl:comment>
        -->
				<xsl:call-template name="processInlineTag">
					<xsl:with-param name="comment" select="exslt:node-set(substring-after($comment, '}'))" />
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
				
			</xsl:when>
			<xsl:otherwise> <!-- The fragment does not contain the specifed link-->
				<xsl:choose>
					<xsl:when test="exslt:node-set($comment)/*" >
						<xsl:copy-of select="$comment" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$comment" disable-output-escaping="yes" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- -->
</xsl:stylesheet>
<!-- End of common-exslt.xsl -->
