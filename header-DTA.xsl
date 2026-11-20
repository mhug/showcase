<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="t"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
  
  <xsl:output method="html"/>
  
  <xsl:template match="t:publicationStmt/t:publisher/t:address">
    <span class="tei-address">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">
        address:
      </span>
      <xsl:for-each select="*">
        <xsl:value-of select="current()"/>
        <xsl:if test="position() != last()">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </span>
  </xsl:template>

  <xsl:template match="t:availability">
    <div class="tei-availability">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">availability</p>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="t:sourceDesc/t:bibl">
    <div class="tei-bibl">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">full bibliographic title: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="t:classCode">
    <span class="tei-classCode">
      <xsl:call-template name="set-data-attributes"/>
      <span class="text-muted small">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@scheme"/>
        <xsl:text>] </xsl:text>
      </span>
      <a href="{@scheme}" target="_blank">
        <xsl:apply-templates/>
      </a>
    </span>
  </xsl:template>

  <xsl:template match="t:resp/t:date">
    <span class="tei-date text-muted small">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:text>[</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt/t:date[@type='publication']">
    <span class="tei-date">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">publication date: </span>
      <xsl:apply-templates></xsl:apply-templates>
    </span>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt/t:date[@type='creation']">
    <span class="tei-date">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">creation date: </span>
      <xsl:apply-templates></xsl:apply-templates>
    </span>
  </xsl:template>
 
  <xsl:template match="t:edition">
    <div class="tei-edition">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">edition: </span>
      <xsl:if test="@n">
        No. <xsl:value-of select="@n"/>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="t:editionStmt">
    <div class="tei-editionStmt ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">editionStmt</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:editorialDecl">
    <div class="tei-editorialDecl ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">editorialDecl</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:encodingDesc">
    <div class="tei-encodingDesc ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">encodingDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:email">
    <span class="tei-email">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">email: </span>
      <a href="mailto:{.}">
        <xsl:apply-templates/>
      </a>
    </span>
  </xsl:template>
  
  <xsl:template match="t:extent">
    <div class="tei-extent ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">extent</p>
      <ul class="ms-3">
        <xsl:for-each select="*">
          <li>
            <xsl:apply-templates select="current()"/>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>
  
  <xsl:template match="t:fileDesc">
    <div class="tei-fileDesc ms-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">fileDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:handDesc">
    <div class="tei-handDesc ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">handDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:handNote">
    <div class="tei-handNote ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p>
        <xsl:variable name="attributes">
          <xsl:for-each select="@*">
            <xsl:text>@</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="." />
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:if test="@*">
          <span class="text-muted">
            <code>
              [<xsl:value-of select="$attributes" />]
            </code>
          </span>
        </xsl:if>
        <xsl:apply-templates/>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt/t:idno">
    <p class="lead fw-bold">identifiers</p>
    <ul class="tei-idno">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:for-each select="t:idno[string-length(normalize-space(.))>0]">
        <li>
          <xsl:apply-templates select="current()"/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  <xsl:template match="t:idno/t:idno[string-length(normalize-space(.))>0]">
    <div>
      <span class="fw-bold">
        <xsl:value-of select="@type"/>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:choose>
        <xsl:when test="starts-with(.,'http')">
          <a href="{.}" target="_blank">
            <span class="tei-idno">
              <xsl:call-template name="set-data-attributes"/>
              <xsl:apply-templates/>
            </span>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <span class="tei-idno">
            <xsl:call-template name="set-data-attributes"/>
            <xsl:apply-templates/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  
  <xsl:template match="t:language">
    <span class="tei-language">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:if test="@ident">
        <span class="text-muted small">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@ident"/>
          <xsl:text>] </xsl:text>
        </span>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="t:langUsage">
    <p class="fw-bold">langUsage: </p>
    <ul class="t-langUsage">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:for-each select="*">
        <li>
          <xsl:apply-templates select="current()"/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  <xsl:template match="t:teiHeader//t:measure">
    <span class="tei-measure">
      <span class="fw-bold">
        <xsl:value-of select="@type"/>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="t:msDesc">
    <div class="tei-msDesc">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">msDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <!-- CDATA blocks -->
  <xsl:template match="t:teiHeader//t:p[text() and not(*)]">
    <p>
      <xsl:value-of select="node()" disable-output-escaping="yes"/>
    </p>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt/t:publisher/t:orgName">
    <xsl:if test="@role">
      <span class="fw-bold">
        <xsl:value-of select="@role"/>
        <xsl:text>: </xsl:text>
      </span>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="//t:teiHeader//t:persName">
    <span class="tei-persName">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:if test="t:nameLink">
        <xsl:apply-templates select="t:nameLink"/>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:if test="t:surname">
        <xsl:for-each select="t:surname">
          <xsl:apply-templates select="current()"/>
          <xsl:if test="position() != last()">
            <xsl:text> </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="t:forename">
        <xsl:if test="t:surname">
          <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:for-each select="t:forename">
          <xsl:apply-templates select="current()"/>
          <xsl:if test="position() != last()">
            <xsl:text> </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </span>
  </xsl:template>
  
  <xsl:template match="t:physDesc">
    <div class="tei-physDesc ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">physDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:profileDesc">
    <div class="tei-profileDesc">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">profileDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt">
    <div class="tei-publicationStmt ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">publicationStmt</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:teiHeader//t:publisher[string-length(normalize-space(.))!=0]">
    <span class="tei-publisher">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">publisher:</span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt/t:publisher[string-length(normalize-space(.))!=0]">
    <div class="tei-publisher">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">publisher</p>
      <div class="ms-3">
        <ul>
          <xsl:for-each select="*">
            <li>
              <xsl:apply-templates select="current()"/>
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:publicationStmt/t:pubPlace">
    <div class="t-pubPlace">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">publication place: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="t:ref[string-length(.)=0]">
    <span class="tei-ref">
      <xsl:call-template name="set-data-attributes"/>
      <i class="bi bi-box-arrow-up-right"></i>
    </span>
  </xsl:template>
  
  <xsl:template match="t:repository">
    <div class="tei-repository">
      <xsl:call-template name="set-data-attributes"/>
      <span class="fw-bold">repository: </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="t:respStmt">
    <div class="tei-respStmt">
      <xsl:call-template name="set-data-attributes"/>
      <span>
        <xsl:for-each select="t:name | t:orgName | t:persName">
          <xsl:apply-templates select="current()"/>
          <xsl:if test="position() != last()">
            <xsl:text> · </xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:apply-templates select="t:resp"/>
    </div>
  </xsl:template>
  
  <xsl:template match="t:seriesStmt">
    <div class="tei-seriesStmt">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">seriesStmt</p>
      <div class="ms-3">
        <div>
          <span class="fw-bold">title: </span>
          <xsl:apply-templates select="t:title"/>
        </div>
        <xsl:if test="t:biblScope">
          <ul>
            <xsl:for-each select="t:biblScope">
              <li>
                <span class="fw-bold">
                  <xsl:value-of select="@unit"/>
                  <xsl:text>: </xsl:text>
                </span>
                <xsl:apply-templates select="current()"/>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:sourceDesc">
    <div class="tei-titleStmt ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">sourceDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:textClass">
    <p class="fw-bold">textClass: </p>
    <ul class="t-textClass">
      <xsl:call-template name="set-data-attributes"/>
      <xsl:for-each select="*">
        <li>
          <xsl:apply-templates select="current()"/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  <xsl:template match="t:titleStmt">
    <div class="tei-titleStmt ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">titleStmt</p>
      <div class="ms-3">
        <div>
          <span class="fw-bold">title: </span>
          <xsl:apply-templates select="t:title"/>
        </div>
        <xsl:if test="t:author">
          <div>
            <span class="fw-bold">author(s): </span>
            <xsl:for-each select="t:author">
              <xsl:apply-templates select="current()"/>
              <xsl:if test="position() != last()">
                <xsl:text> · </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </div>
        </xsl:if>
        <xsl:if test="t:editor">
          <div>
            <span class="fw-bold">editor(s): </span>
            <xsl:for-each select="t:editor">
              <xsl:apply-templates select="current()"/>
              <xsl:if test="position() != last()">
                <xsl:text> · </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </div>
        </xsl:if>
        <xsl:if test="t:respStmt">
          <div>
            <span class="fw-bold">responsibilities:</span>
            <ul class="ms-3">
              <xsl:for-each select="t:respStmt">
                <li>
                  <xsl:apply-templates select="current()"/>
                </li>
              </xsl:for-each>
            </ul>
          </div>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="t:typeDesc">
    <div class="tei-typeDesc ms-3 mb-3">
      <xsl:call-template name="set-data-attributes"/>
      <p class="lead fw-bold">typeDesc</p>
      <div class="ms-3">
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>