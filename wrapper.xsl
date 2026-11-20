<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="t"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">

  <xsl:import href="config.xsl"/>
  <xsl:import href="tei.xsl"/>
  <xsl:import href="header-generic.xsl"/>

  <xsl:output method="html"/>

  <xsl:param name="dirname" select="''"/>
  <xsl:param name="headers-dir" select="'headers'"/>

  <xsl:template name="custom-header">
    <xsl:variable name="specific" select="concat($headers-dir, '/', $dirname, '.xml')"/>
    <xsl:variable name="default"  select="concat($headers-dir, '/default.xml')"/>

    <xsl:choose>
      <xsl:when test="document($specific)">
        <xsl:copy-of select="document($specific)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="document($default)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/t:TEI">
    <xsl:call-template name="doctype"/>
    <html>
      <head>
        <xsl:call-template name="html-header"/>
      </head>

      <body>
        <div id="teik-spinner" class="position-fixed top-0 start-0 w-100 h-100 bg-dark bg-opacity-50 d-flex justify-content-center align-items-center d-none" style="z-index: 1050">
          <div class="spinner-border text-dark" role="status">
            <span class="visually-hidden">Loading…</span>
          </div>
        </div>

        <xsl:call-template name="custom-header"/>

        <div class="content">
          <main class="flex-shrink-0">
            <div class="container">
              <div class="row">
                <div class="col-lg-8 col-md-12 tei mx-auto p-3">
		    <h1>DI-Showcase</h1>
                  <xsl:apply-templates/>
                </div>
              </div>
            </div>
          </main>
        </div>

        <footer>
          <xsl:call-template name="html-footer"/>
        </footer>

        <div class="teik-toolset">
          <button type="button" class="btn btn-light btn-default btn-outline-dark hidden" id="toggleFacsimiles"><i class="bi bi-file-richtext" title="show facsimiles" data-bs-toggle="tooltip"></i></button>
          <button type="button" class="btn btn-light btn-default btn-outline-dark" id="toggleTeiHeader"><i class="bi bi-card-heading" title="show header" data-bs-toggle="tooltip"></i></button>
          <button type="button" class="btn btn-light btn-default btn-outline-dark" id="toggleDarkMode"><i class="bi bi-circle-half" title="toggle dark mode" data-bs-toggle="tooltip"></i></button>
        </div>

        <script src="{$base}lib/bootstrap/bootstrap.bundle.min.js"></script>
      </body>
    </html>
  </xsl:template>

  <!-- <!DOCTYPE html> declaration -->
  <xsl:template name="doctype">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#10;</xsl:text>
  </xsl:template>

  <!-- /html/head content -->
  <xsl:template name="html-header">
    <xsl:param name="title"/>
    <meta name="robots" content="noindex"/>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>showcase</title>

    <!--    <link rel="icon" type="image/png" href="{$base}images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="{$base}images/favicon.svg" />
    <link rel="shortcut icon" href="{$base}images/favicon.ico" /> -->
    <link rel="apple-touch-icon" sizes="180x180" href="{$base}images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="teikiss" />
    <link rel="manifest" href="{$base}images/site.webmanifest" />

    <link href="{$base}lib/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="{$base}lib/bootstrap-icons/bootstrap-icons.css"/>

    <link href="{$base}tei.css" rel="stylesheet"/>

    <script src="{$base}lib/spotlight/spotlight.bundle.js"></script>

    <script src="{$base}lib/popper/popper.min.js"></script>
    <link rel="stylesheet" href="{$base}lib/tippy/tippy.css" />
    <script src="{$base}lib/tippy/tippy.umd.min.js"></script>

    <script>
      window.dtaBase = '<xsl:value-of select="$dtaBase"/>'
    </script>

    <script type="module" src="{$base}tei.js"></script>
  </xsl:template>

  <!-- /html/body/footer content -->
  <xsl:template name="html-footer">
    <div class="teik-footer text-center bg-secondary-subtle p-3 text-muted">
      Beware: dragons dwell here. Testing version in progress. Brought to you by <a href="https://github.com/haoess/teikiss">tei<span style="color:transparent;text-shadow:0 0 green">💋</span></a>.
    </div>
  </xsl:template>
</xsl:stylesheet>
