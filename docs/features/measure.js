import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('<measure>', () => {
  document.querySelectorAll('.tei-text .tei-measure').forEach(el => {
    if (!el.textContent.trim()) el.classList.add('tei-measure-empty')
    const entries = Array.from(el.attributes).filter(a => a.name.startsWith('data-')).map(a => `${a.name.slice(5)}: ${a.value}`)
    el.textContent = entries.join(', ')
  })
})