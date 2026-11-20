// entry: register feature modules and start domReady
(async function() {
  // load feature modules in parallel using dynamic import to avoid top-level import syntax errors
  await Promise.all([
    import('./lib/spinner.js'),
    import('./lib/utils.js'),
    import('./features/attributesInTooltips.js'),
    import('./features/badges.js'),
    import('./features/choice.js'),
    import('./features/editorialNotes.js'),
    import('./features/fffc.js'),
    import('./features/figure.js'),
    import('./features/footnotes.js'),
    import('./features/formula.js'),
    import('./features/measure.js'),
    import('./features/metamark.js'),
    import('./features/misc.js'),
    import('./features/otherNotes.js'),
    import('./features/pb.js'),
    import('./features/ref.js'),
    import('./features/teiHeader.js'),
    import('./features/htmlTitle.js'),
    import('./features/toc.js'),
    import('./features/tooltips.js'),
  ])

  await import('./features/externalLinks.js')
  await import('./features/darkMode.js')

  const { runDomReady } = await import('./lib/domReady.js')
  runDomReady()
})()