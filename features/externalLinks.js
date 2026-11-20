import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('external links', () => {
  document.querySelectorAll('a[href^="http"]').forEach(link => {
    link.setAttribute('target', '_blank')
    link.setAttribute('rel', 'noopener noreferrer')
  })
})