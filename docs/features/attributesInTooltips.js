import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('show attributes in tooltips', () => {
  document.querySelectorAll('.tei-add, .tei-del, .tei-gap, .tei-name, .tei-orgName, .tei-persName, .tei-placeName, .tei-supplied').forEach(el => {
    const dataAttributes = [...el.attributes]
      .filter(attr => attr.name.startsWith('data-') && !attr.name.startsWith('data-bs-'))
      .map(attr => `${attr.name.replace(/^data-/, '')}:"${attr.value}"`)
      .join(' ')
    const teiEl = [...el.classList].find(c => c.startsWith('tei-'))?.replace(/^tei-/, '')
    const tooltipPosition = (teiEl === 'add' || teiEl === 'del') ? 'bottom' : 'top'
    if (dataAttributes) {
      if (window.bootstrap) {
        new bootstrap.Tooltip(el, { title: `${teiEl} ${dataAttributes}`, trigger: 'hover', placement: tooltipPosition })
      } else {
        el.setAttribute('title', `${teiEl} ${dataAttributes}`)
      }
    }
  })
})