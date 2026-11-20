# teikiss

teikiss is a web application framework that provides a user-friendly interface for viewing and interacting with TEI-XML encoded documents. It is built using modern web technologies and offers a range of features to enhance the user experience.

## Key features

* **DTABf compliance**: support for all (okay, most) elements mentioned in the [DTABf guidelines](https://deutschestextarchiv.de/doku/basisformat).
* **Responsive design**: teikiss is designed to be responsive, ensuring a seamless viewing experience across different devices and screen sizes.
* **Simple styling**: Adjust the CSS rules to create your own look and feel.
* **Facsimile viewer**: Browse and interact with high-resolution digital facsimiles of historical documents.
* **Zoom and pan**: Easily zoom in and pan across the facsimiles to explore details and navigate through the document.
* **Tooltips and badges**: Display additional information and badges on the facsimiles to provide context and insights.
* **Dark mode**: Switch to a dark mode theme for a more comfortable reading experience.
* **Table of contents**: Quickly navigate through the document using a dynamic table of contents.
* **Customizable**: Customize the appearance using custom headers to suit your preferences.
* **Third-party integrations**: Seamlessly integrate with popular third-party services for enhanced functionality.

## Prerequisites

Before using teikiss, make sure you have the following prerequisites installed on your system:

* `jq` (Debian package `jq`)
* `make`, preferably GNU make
* `xsltproc` (Debian package `xsltproc`)

## Setup

1. Copy `sources.mk.examples` to `sources.mk`.

2. Link your input text source: Open `sources.mk`, and adjust
   `edition.src := ~/src/edition-humboldt-digital` to your base
   directory (= your project) and adjust the `data` in `ln -sfn
   $(edition.src)/data input/edition` to the subdirectory, containing
   the TEI-XML files. The idea is, that your project may contain more
   than just TEI-XML files, but all the other stuff is irrelevant to
   teikiss.

3. Metadata extraction: Open `index.xsl` and adjust to your metadata,
   you’ll find some handy defaults there. Note: each but the last
   field has to end with a tab character, produced by
   `<xsl:text>&#x9;</xsl:text>`. Be sure, to use `normalize-space(…)`
   for each field, preventing tabs, newlines and other whitespace.
   This XSL-file generates a tab separated list, which is
   converted to JSON by the nifty `jq` tool and then used as a
   listing for your TEI collection. Most likely (in case one is
   working with TEI-files at least) one doesn't have to 
   change anything.

4. Let’s look at `sources.mk` again: For each metadata field, parsed
   in the previous step, create an entry in `editions.title`. This is
   a list of dictionairies (or, in Perl speak, a list of hashes),
   where the key must always be `title`, and the value is the name to
   display for the column.

5. Create an empty output directory: `mkdir -p output`.

6. Let `make` do the work:

- make index
- make html
- make output/showcase/index.html 

All generated files are now in the `output` directory. You can now set-up your webserver:


cd ~/Desktop/github/dta/teikiss
python3 -m http.server 8000


## More customization

### Custom headers

You can style your own custom page header, for navigation etc. Just create a file `headers/edition.xml`. The contents of the file is loaded via XSLT, so while it should look like HTML, it must be well-formed XML. See the `headers` directory for some examples.

### Custom styling

Just adjust `tei.css`. You can also write your own JS plugins, see `tei.js` on how to load them and the `features` directory for examples.

## Batteries included

teikiss includes a range of third-party libraries and fonts to enhance its functionality and aesthetics. Some of the notable inclusions are:

* [Bootstrap v5.3.3](https://getbootstrap.com/) – A popular front-end framework for building responsive and mobile-first websites. Bootstrap is licensed under [MIT](https://github.com/twbs/bootstrap/blob/main/LICENSE).
* [Bootstrap Icons v1.13.1](https://icons.getbootstrap.com/) – A collection of open-source icons for use with Bootstrap. Bootstrap Icons are licensed under [MIT](https://github.com/twbs/icons/blob/main/LICENSE).
* [spotlight.js](https://github.com/nextapps-de/spotlight/)- A lightweight JavaScript library for creating interactive image gallerys. Spotlight is licensed under a [Apache License Version 2.0](https://github.com/nextapps-de/spotlight/blob/master/LICENSE).
* [Junicode 2](https://github.com/psb1558/Junicode-font) – An open-source font that supports a wide range of Unicode characters. Junicode 2 is licensed under the [SIL Open Font License, Version 1.1](https://github.com/psb1558/Junicode-font?tab=OFL-1.1-1-ov-file#readme).
* [Noto Sans](https://fonts.google.com/noto/specimen/Noto+Sans) – A collection of open-source fonts designed for readability across languages and scripts.. Noto sans is licensed under the [SIL Open Font License, Version 1.1](https://fonts.google.com/noto/specimen/Noto+Sans/license).
* [popperjs](https://floating-ui.com/) – A dependency of Bootstrap for positioning popovers and tooltips. popperjs is licensed under [MIT](https://github.com/floating-ui/popper.js.org/blob/master/LICENSE).
* [tippyjs](https://github.com/atomiks/tippyjs) – A lightweight JavaScript library for creating interactive tooltips. tippyjs is licensed under [MIT](https://github.com/atomiks/tippyjs/blob/master/LICENSE).
* [DataTables](https://datatables.net/) – A JS table library. DataTables is licensed under the [MIT](https://datatables.net/license/mit).
