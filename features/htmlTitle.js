import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('<title>', () => {
  const titleEl = document.querySelector('.tei-titleStmt .tei-title')
  if (!titleEl) return
  const currentTitle = document.title || ''
  const newTitle = titleEl.textContent.trim()
  if (newTitle) document.title = `${newTitle} – ${currentTitle}`
})