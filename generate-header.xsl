<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:param name="teiHeader" select="'generic'"/>
  
  <xsl:template match="/">
    <xsl:element name="xsl:stylesheet" namespace="http://www.w3.org/1999/XSL/Transform">
      <xsl:attribute name="version">1.1</xsl:attribute>
      <xsl:element name="xsl:import" namespace="http://www.w3.org/1999/XSL/Transform">
        <xsl:attribute name="href">
          <xsl:value-of select="concat('header-', $teiHeader, '.xsl')"/>
        </xsl:attribute>
      </xsl:element>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>