import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

onDomContentLoaded("<table facs='...'>", () => {
  document.querySelectorAll('table.tei-table[data-facs]').forEach(table => {
    const src = table.getAttribute('data-facs')
    const figure = document.createElement('figure')
    const img = document.createElement('img')
    img.src = src
    img.alt = 'Facsimile'
    figure.appendChild(img)
    if (table.hasAttribute('data-rendition')) figure.setAttribute('data-rendition', table.getAttribute('data-rendition'))
    table.parentElement.insertBefore(figure, table)
  })
})