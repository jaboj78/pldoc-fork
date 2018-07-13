<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/APPLICATION">
<?xml version="1.0" encoding="UTF-8"?>
<gexf xmlns="http://www.gexf.net/1.2draft" version="1.2">
    <meta lastmodifieddate="2009-03-20">
        <creator>PLDoc</creator>
        <description>A hello world! file</description>
    </meta>
    <graph mode="static" defaultedgetype="directed">

         <attributes class="node">
            <attribute id="0" title="url" type="string"/>
            <attribute id="1" title="lines" type="float"/>
            <attribute id="2" title="schema" type="string">
            <attribute id="3" title="object_type" type="string">
            <attribute id="4" title="object_name" type="string">
            <attribute id="5" title="method_name" type="string"/>
            <attribute id="6" title="comment_first_line" type="string"/>
            <attribute id="7" title="comment" type="string"/>
        </attributes>

 <!--
         <nodes>
            <node id="0" label="Hello" />
            <node id="1" label="Word" />
        </nodes>
        <edges>
            <edge id="0" source="0" target="1" />
        </edges>
 -->
    <nodes>
	    <xsl:for-each select=".//*[local-name()='FUNCTION' or local-name()='PROCEDURE' or local-name()='TRIGGER' ] ">
	    <xsl:element name="node" >
		    <xsl:attribute name="id"><value-of select="PLSCOPE/@pldocID" /> </xsl:attribute>
		    <xsl:attribute name="label"><value-of select="concat(../@SCHEMA,'.', ../@NAME,'.', ./@NAME)" /></xsl:attribute>
		    <xsl:element name="attvalues">
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">0</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="./@url"/> </xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">1</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="./SUMMARY/@END_LINE - ./SUMMARY/@START_LINE + 1 "/> </xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">2</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="../@SCHEMA"/></xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">3</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="../@NAME"/></xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">4</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="../@TYPE"/></xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">5</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="./@NAME"/></xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">6</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="./COMMENT_FIRST_LINE/text()" /></xsl:attribute>
			    </xsl:element>
			    <xsl:element name="attvalue">
				    <xsl:attribute name="for">7</xsl:attribute>
				    <xsl:attribute name="value"><value-of select="./COMMENT/text()"/></xsl:attribute>
			    </xsl:element>
		    </xsl:element>
	    </xsl:element>
	    </xsl:for-each>
    </nodes>
    
    <!--
        <edges>
            <edge id="0" source="0" target="1" />
        </edges>
     -->

    <edges>
	    <xsl:for-each select=".//CALLER ">
		    <xsl:element name="edge" >
			    <xsl:attribute name="id"><value-of select="generate-id(.)" /> </xsl:attribute>
		            <xsl:attribute name="target"><value-of select="../PLSCOPE/@pldocID" /> </xsl:attribute>
			    <xsl:attribute name="source"><value-of select="@CALLING_ID" /> </xsl:attribute>
		    </xsl:element>
	    </xsl:for-each>
    </edges>
    </graph>
</gexf>
</xsl:template>

</xsl:stylesheet> 
