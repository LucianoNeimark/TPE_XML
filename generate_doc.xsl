<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="//artist_data/artist">
= <xsl:value-of select="data(./name)"/>
<xsl:text>
    
</xsl:text>
        
        <xsl:apply-templates/>
        <xsl:call-template name="disambugation-bullet">
            <xsl:with-param name="disambiguation" select="./disambiguation" />
        </xsl:call-template>

        <xsl:call-template name="type">
            <xsl:with-param name="type" select="./type" />
        </xsl:call-template>

        <xsl:call-template name="birth-place-bullet">
            <xsl:with-param name="area" select="./area" />
        </xsl:call-template>

        <xsl:call-template name="life-span-bullet">
            <xsl:with-param name="life-span" select="./life-span" />
        </xsl:call-template>

=== Recordings
        <xsl:for-each select="./recordings/recording">
        <xsl:call-template name="recording">
            <xsl:with-param name="recording" select="." />
        </xsl:call-template>
        </xsl:for-each>


</xsl:template>


<!-- Template que genera bullet point a partir de un nodo de texto -->



<xsl:template name ="disambugation-bullet">
    <xsl:param name="disambiguation"/>
    <xsl:if test="data($disambiguation)">
* Disambiguation:  <xsl:value-of select="data($disambiguation)"/>
    </xsl:if>
</xsl:template> 

<xsl:template name ="type">
    <xsl:param name="type"/>
* Type:  <xsl:value-of select="data($type)"/>
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
<xsl:template match="//artist/name"/>
<xsl:template match="//artist/area"/>
<xsl:template match="//artist/life-span"/>
<xsl:template match="//artist/recordings"/>
<xsl:template match="//artist/type"/>
<xsl:template match="//artist/disambiguation"/>





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
        <xsl:call-template name="releases">
            <xsl:with-param name="release" select="." />
        </xsl:call-template>
        </xsl:for-each> 
|===
</xsl:template> 

<xsl:template name ="releases">
    <xsl:param name="release"/>
|<xsl:value-of select="data($release/title)"/>| <xsl:value-of select="data($release/date)"/> | <xsl:value-of select="data($release/country)"/>| <xsl:value-of select="data($release/type)"/>|  <xsl:value-of select="data($release/track-number)"/>
</xsl:template> 
<xsl:template match="//error">
= <xsl:value-of select="data(.)"/>
</xsl:template>
</xsl:stylesheet>