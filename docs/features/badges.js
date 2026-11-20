import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('type of element as badge', () => {
  document.querySelectorAll('.tei-div[data-type], .tei-figure[data-type], .tei-head[data-type], .tei-lg[data-type], .tei-quote[data-type]').forEach(el => {
    const wrapper = document.createElement('div')
    wrapper.classList.add('teik-div-wrapper')
    const teiClass = Array.from(el.classList).find(c => c.startsWith('tei-'))?.replace(/^tei-/, '') || 'elem'
    const label = document.createElement('span')
    label.classList.add('teik-div-label', 'badge', 'text-bg-secondary')
    label.textContent = `${teiClass}: ${el.dataset.type || ''}`
    el.parentNode.insertBefore(wrapper, el)
    wrapper.appendChild(el)
    wrapper.appendChild(label)
  })
})