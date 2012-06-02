<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    exclude-result-prefixes="xs xd text"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 2, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Tom Elliott</xd:p>
            <xd:p>Convert dissertation bibliography to simple RDF.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="text"/>
    
    <xsl:template match="/">
        <xsl:text></xsl:text>@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .<xsl:text>
</xsl:text>
        <xsl:text></xsl:text>@prefix bibo: &lt;http://purl.org/ontology/bibo/&gt; .<xsl:text>
            
</xsl:text>
        <xsl:apply-templates select="//text:p[@text:style-name='P18']"/>
    </xsl:template>
    
    <xsl:template match="text:p[@text:style-name='P18']">
        <xsl:text></xsl:text>&lt;http://id.stoa.org/bibl/<xsl:value-of select="replace(lower-case(normalize-space(text()[1])), ' ', '-')"/>&gt;<xsl:text> a bibo:Document ;</xsl:text><xsl:text>
    </xsl:text><xsl:text>dcterms:title "</xsl:text><xsl:value-of select="normalize-space(text()[1])"/>"<xsl:text> ;
    </xsl:text><xsl:text>dcterms:description "</xsl:text>
        <xsl:for-each select="node()">
            <xsl:if test="count(preceding-sibling::node()) &gt; 0 and count(following-sibling::node()) &gt; 0">
                <xsl:text></xsl:text><xsl:apply-templates select="."/><xsl:text></xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:choose>
            <xsl:when test="node()[last()]/self::text()"><xsl:value-of select="normalize-space(node()[last()])"/></xsl:when>
            <xsl:otherwise><xsl:apply-templates select="node()[last()]"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>" .
        
</xsl:text>

    </xsl:template>
    
    <xsl:template match="text:span"><xsl:apply-templates/></xsl:template>
    
    <xsl:template match="text()">
        <xsl:if test=". = ' ' or . = '\n'"><xsl:text> </xsl:text></xsl:if>
        <xsl:if test="normalize-space(.) = ' '"><xsl:text> </xsl:text></xsl:if>
        <xsl:if test="substring(., 1, 1) = ' ' or substring(., 1, 1) = '\n'"><xsl:text> </xsl:text></xsl:if>
        <xsl:text></xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text></xsl:text>
        <xsl:if test="substring(., string-length(.), 1) = ' ' or substring(., string-length(.), 1)"><xsl:text> </xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="*"/>
    
</xsl:stylesheet>