<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="t"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">

  <xsl:import href="wrapper.xsl"/>

  <xsl:template match="/t:TEI">
    <xsl:call-template name="doctype"/>
    <html>
      <head>
        <xsl:call-template name="html-header"/>
        <link rel="stylesheet" href="{$base}lib/datatables/dataTables.bootstrap5.min.css"/>
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
                <div class="col-lg-8 col-md-8 mx-auto p-3">
		    <h1>DI-Showcase</h1>
	 <p>
	  Minimal working example of a test corpus for showcasing the
	  potential of <a href="https://github.com/deutschestextarchiv/teikiss">TEIKiss</a> in the context of presenting
	  TEI-annotated research data.  
      </p>
         <ul>
	     <li>All files could be stored in a public github-repo and
		 thereby made available for download.</li>
	     <li>The search implemented is linked to the dstar search engine of
	 the <a href="https://www.bbaw.de/forschung/zentren/zentrum-sprache">Zentrum
		     Sprache</a> at Berlin-Brandenburg Academy of
	 Sciences and Humanities. As the working example is not
	 indexed, the search here has functional means only.</li>
	     <li>Finally, direct access to the texts is made possible via
	     an advanced XML2HTML-transformation.</li>
	 </ul>
	</div>

        <div class="col-lg-8 col-md-8 mx-auto p-3">
        <h3>Download</h3>
        <table class="table table-borderless" style="width:auto">
	  <tr>
            <td><b>GitHub:</b></td>
            <td>
              <a href="https://github.com/mhug/showcase_data">Korpus DI-Showcase</a>
            </td>
          </tr>
	</table>
	</div>

        <div class="col-lg-8 col-md-8 mx-auto p-3">
        <h3>Search</h3>
        <p>
          Corpus deployment allows complex <a
	      href="https://ddc.dwds.de/dstar/dtaxl">search queries (dstar-interface)</a>
          based on linguistic pre-analysis (lemmatizing, POS tagging,
          orthographical normalization), corpus analysis with <a
	      href="https://ddc.dwds.de/dstar/dtaxl/hist.perl">Wortverlaufskurven</a>
          as well as a diachronic collocation analysis via 
          <a href="https://ddc.dwds.de/dstar/dtaxl/diacollo/">DiaCollo</a>.
        </p>
        <form class="mb-3 mx-auto" method="get" action="https://ddc.dwds.de/dstar/dtaxl/dstar.perl">
          <div class="col-8">
            <div class="input-group">
              <input class="form-control" type="search" name="q" placeholder="DDC-Abfrage">
              <button type="submit" class="btn btn-primary">suchen</button>
	      </input>
            </div>
          </div>
        </form>
	</div>

	<div class="col-lg-8 col-md-12 mx-auto p-3">
        <h3>Access to the texts</h3>
	<p>
	  Choose one of the files below by following the link. This will open
	  an automatically generated text-view of the work based on
	  the annotations within the XML-files. A view buttons on the
	  foot of the right hand side allow for more insights:
	  <ul>
	      <li><b>toggle TOC</b> will show a table of content (if
		  available)</li>
	      <li><b>toggle dark mode</b> will switch between background
		  color from dark to light and vice versa
	      </li>
	      <li><b>show header</b> will open the TEIHeader and will show
		  the bibliographical metadata of the text
	      </li>
	      <li><b>show facimiles</b> (if available) will load the facsimiles of the digitized book
	      </li>
	  </ul>
	</p>
        </div>

	<div class="col-lg-8 col-md-12 mx-auto p-3">
		<div style="margin-top: 5ex;">
                  <table id="index-table" class="table table-striped table-hover">
                    <thead></thead>
                    <tbody></tbody>
                  </table>
                </div>
        </div>

              </div>
            </div>
          </main>
        </div>

        <footer>
          <xsl:call-template name="html-footer"/>
        </footer>

        <div class="teik-toolset">
          <button type="button" class="btn btn-light btn-default btn-outline-dark" id="toggleDarkMode">
            <i class="bi bi-circle-half" title="toggle dark mode" data-bs-toggle="tooltip"></i>
          </button>
        </div>

        <script src="{$base}lib/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="{$base}lib/datatables/jquery-3.7.1.min.js"></script>
        <script src="{$base}lib/datatables/dataTables.min.js"></script>
        <script src="{$base}lib/datatables/dataTables.bootstrap5.min.js"></script>
        <script type="module">
          const resp = await fetch('index.json');
          const json = await resp.json();

          const columns = json.columns.map((col, i) => {
            if (i === 1) {
              return {
                ...col,
                render: (data, type, row) =>
                  type === 'display'
                    ? `&lt;a href="${data}.html"&gt;${data}&lt;/a&gt;`
                    : data
              };
            }
            return col;
          });

          new DataTable('#index-table', {
            ajax: {
              url: 'index.json',
              dataSrc: 'data'
            },
            columns 
          })
        </script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
