import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

onDomContentLoaded('metamark', () => {
  document.querySelectorAll('.tei-metamark').forEach(el => {
    el.title = 'metamark'
    el.setAttribute('data-bs-toggle', 'tooltip')
  })
  updateTooltips()
})