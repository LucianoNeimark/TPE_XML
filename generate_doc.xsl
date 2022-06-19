<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- Template que genera bullet point a partir de un nodo de texto -->



<xsl:template name ="disambugation-bullet">
    <xsl:param name="disambiguation"/>
    <xsl:if test="boolean(./text())">
        * Disambiguation:  <xsl:value-of select="data($disambiguation)"/>
    </xsl:if>
</xsl:template> 

<xsl:template name ="type">
    <xsl:param name="type"/>
        * Type:  <xsl:value-of select="$data($type)"/>
</xsl:template>  

<xsl:template name ="birth-place-bullet">
    <xsl:param name="area"/>
        * Birth Place:  <xsl:value-of select="data($area/origin)"/>, <xsl:value-of select="data($area/name)"/>
</xsl:template> 

<xsl:template name ="life-span-bullet">
    <xsl:param name="life-span"/>
    
    <xsl:if test="data($life-span/ended)">
        * Life-Span:  <xsl:value-of select="data($life-span/begin)"/> -  <xsl:value-of select="data($life-span/end)"/>
    </xsl:if>

    <xsl:if test="not(data($life-span/ended))">
        * Life-Span:  <xsl:value-of select="data($life-span/begin)"/> - present
    </xsl:if>
    
</xsl:template> 


<xsl:template name ="recording">
    <!-- H4 con el /recording/title -->
    <!-- . Length /recording/length SI EXISTE -->
    <!-- . First release date: /recording/first-release-date SI EXISTE -->
    <!-- H6 de releases + tabla por cada release (podemos reutilizar codigo) -->
    <xsl:param name="recording"/>
    ==== <xsl:value-of select="data($recording/title)"/> 
    <xsl:if test="boolean($recording/length/text())"> . Length: <xsl:value-of select="data($recording/length)"/> </xsl:if>
    <xsl:if test="boolean($recording/first-release-date/text())"> . First release date: <xsl:value-of select="data($recording/first-release-date)"/> </xsl:if>
    ====== Releases
    <!-- Aca va el llamado al template de la tabla -->
    
    |===
        |Title|Date|Country|Type|Track-Number
        <!-- for each y llamar al templete releases con cada release -->
        <xsl:for-each select="$recording/release"> 
        <xsl:apply-templates/>
        <xsl:call-template name="releases">
            <xsl:with-param name="release" select="." />
        </xsl:call-template>
            




    |===
</xsl:template> 

<xsl:template name ="releases">
    <xsl:param name="release"/>
    
 |<xsl:value-of select="data($release/title)"/>| <xsl:value-of select="data($release/date)"/> | <xsl:value-of select="data($release/country)"/>| <xsl:value-of select="data($release/type)"/>|  <xsl:value-of select="data($release/track-number)"/>
    
</xsl:template> 







</xsl:stylesheet>