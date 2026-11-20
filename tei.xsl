<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="t"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
  
  <xsl:output method="html"/>
  
  <xsl:template match="/t:TEI/t:teiHeader">
    <div class="tei-teiHeader hidden">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="/t:TEI/t:facsimile"/>
  
  <!-- <text> wrapper -->
  <xsl:template match="/t:TEI/t:text">
    <div class="tei-text">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!-- TEI text elements -->
  <xsl:template match="t:*" priority="-9">
    <span class="tei-{local-name(.)}">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!-- data attributes -->
  <xsl:template name="set-data-attributes">
    <xsl:for-each select="@*">
      <xsl:call-template name="data-attribute">
        <xsl:with-param name="name" select="name(current())"/>
        <xsl:with-param name="value" select="current()"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="data-attribute">
    <xsl:param name="name"/>
    <xsl:param name="value"/>
    <xsl:attribute name="data-{translate($name, ':', '-')}">
      <xsl:value-of select="$value"/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- **************************** -->
  <!-- <teiHeader-->


  
  <!-- ************************************ -->
  <!-- <text -->
  
  <!-- tables -->
  <xsl:template match="t:table" priority="2">
    <table class="tei-table table">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:apply-templates/>
    </table>
  </xsl:template>
  
  <xsl:template match="t:row">
    <tr>
      <xsl:call-template name="set-data-attributes"/>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>
  
  <xsl:template match="t:cell" priority="2">
    <td class="tei-cell">
      <xsl:if test="@rows">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rows"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@cols">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@cols"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="set-data-attributes"/>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <!--
    Line breaks: <lb/>

    @break="no"  → hyphenation across lines
    @break="yes" → separate words across lines
  -->
  <xsl:template match="t:lb[@break='no']" priority="100">
    <xsl:variable name="prev" select="preceding-sibling::text()[normalize-space()][1]"/>
    <xsl:variable name="prev-trimmed" select="normalize-space($prev)"/>
    <xsl:variable name="last-char" select="substring($prev-trimmed, string-length($prev-trimmed), 1)"/>
    <xsl:if test="not($last-char = '-')">
      <span class="tei-supplied">-</span>
    </xsl:if>
    <span class="tei-lb">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
</xsl:stylesheet>