<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="t"
                xpath-default-namespace="http://www.tei-c.org/ns/1.0">

  <xsl:output method="text" indent="no" encoding="utf-8"/>

  <xsl:param name="dirname"/>

  <xsl:param name="filename">
     <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>
  </xsl:param>

  <xsl:template match="/">
    <!-- directory -->
    <xsl:value-of select="$dirname"/>
    <xsl:text>&#x9;</xsl:text>

    <xsl:value-of select="$filename"/>
    <xsl:text>&#x9;</xsl:text>

    <!-- Text 
    <xsl:text>&lt;a href="</xsl:text>
    <xsl:text>DATEI</xsl:text>
    <xsl:text>"&gt;</xsl:text>
    <xsl:value-of select="normalize-space(string(/t:TEI/t:teiHeader/t:fileDesc/t:titleStmt/t:author/t:persName/t:surname))"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="normalize-space(string(/t:TEI/t:teiHeader/t:fileDesc/t:titleStmt/t:title))"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="normalize-space(string(/t:TEI/t:teiHeader/t:fileDesc/t:sourceDesc/t:bibl/t:date))"/>
    <xsl:text>&lt;/a&gt;</xsl:text>
    <xsl:text>&#x9;</xsl:text>
    -->


    <!-- XML -->
    <xsl:text>&lt;a href="</xsl:text>
    <xsl:text>https://raw.githubusercontent.com/mhug/showcase_data/refs/heads/main/data/xml/</xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:text>.xml</xsl:text>
    <xsl:text>"&gt;XML&lt;/a&gt;</xsl:text>
    <xsl:text>&#x9;</xsl:text>

    <!-- Derivates -->
    <xsl:text>&lt;a href="</xsl:text>
    <xsl:text>https://raw.githubusercontent.com/mhug/showcase_data/refs/heads/main/data/txt/</xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:text>.txt</xsl:text>
    <xsl:text>"&gt;TXT&lt;/a&gt;</xsl:text>
    <xsl:text>&#x9;</xsl:text>

    <!-- Tools -->
    <xsl:text>&lt;a href="</xsl:text>
    <xsl:text>https://voyant-tools.org/?input=</xsl:text>
    <xsl:text>https://raw.githubusercontent.com/mhug/showcase_data/refs/heads/main/data/xml/</xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:text>.xml</xsl:text>
    <xsl:text>"&gt;Voyant&lt;/a&gt;</xsl:text>
    <xsl:text> / </xsl:text>
    <xsl:text>&lt;a href="</xsl:text>
    <xsl:text>https://switchboard.clarin.eu/#/vlo/</xsl:text>
    <xsl:text>https%3A%2F%2Fraw.githubusercontent.com%2Fmhug%2Fshowcase_data%2Frefs%2Fheads%2Fmain%2Fdata%2Ftxt%2F</xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:text>.txt</xsl:text>
    <xsl:text>"&gt;LRS&lt;/a&gt;</xsl:text>
    <!--<xsl:text>&#x9;</xsl:text>-->

    <!-- line break -->
    <xsl:text>&#x0a;</xsl:text>
  </xsl:template> 

</xsl:stylesheet>
