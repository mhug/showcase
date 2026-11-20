<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="t"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
  
  <xsl:output method="html"/>
  
  <xsl:template name="linkify">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="starts-with($text, 'http://') or starts-with($text, 'https://')">
        <a href="{$text}">
          <xsl:value-of select="$text"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:teiHeader//t:*">
    <xsl:variable name="textContent" select="normalize-space(.)"/>
    <xsl:variable name="hasOnlyText" select="not(*) and $textContent != ''"/>
    <xsl:variable name="attributes" select="@*"/>
    
    <div>
      <span class="teik-element">
        <a href="https://tei-c.org/release/doc/tei-p5-doc/de/html/ref-{local-name()}.html">
          <xsl:value-of select="local-name()"/>
        </a>
      </span>
      
      <xsl:if test="$attributes">
        <xsl:text> [</xsl:text>
        <xsl:for-each select="$attributes">
          <span class="teik-attr">
            <xsl:value-of select="name()"/>
          </span>
          <xsl:text>="</xsl:text>
          <span class="teik-attrval">
            <xsl:call-template name="linkify">
              <xsl:with-param name="text" select="."/>
            </xsl:call-template>
          </span>
          <xsl:text>"</xsl:text>
          <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
      </xsl:if>
      
      <xsl:choose>
        <xsl:when test="$hasOnlyText">
          <xsl:text> </xsl:text>
          <span class="tei-{local-name(.)}">
            <xsl:call-template name="set-data-attributes"/>
            <xsl:call-template name="linkify">
              <xsl:with-param name="text" select="$textContent"/>
            </xsl:call-template>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <div class="tei-{local-name(.)}">
            <xsl:call-template name="set-data-attributes"/>
            <xsl:apply-templates/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
</xsl:stylesheet>