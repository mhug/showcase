import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('@ref', () => {
  document.querySelectorAll('.tei-text [data-ref]').forEach(el => {
    const url = el.getAttribute('data-ref')
    if (!url) return
    if (url.search(/^https?:\/\//) == -1) return
    const link = document.createElement('a')
    link.href = url.replace(/\s.*/, '')
    link.innerHTML = el.innerHTML
    el.innerHTML = ''
    el.appendChild(link)
  })
})

onDomContentLoaded('<ref>', () => {
  document.querySelectorAll('.tei-text .tei-ref, .tei-text [class^="tei-"][data-target^="http://"], .tei-text [class^="tei-"][data-target^="https://"]').forEach(el => {
    const url = el.getAttribute('data-target')
    if (!url) return
    const link = document.createElement('a')
    link.href = url.replace(/\s.*/, '')
    link.innerHTML = el.innerHTML
    el.innerHTML = ''
    el.appendChild(link)
  })
})