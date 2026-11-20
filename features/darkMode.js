import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('toggle dark mode', () => {
  const toggle = document.getElementById('toggleDarkMode')
  if (!toggle) return

  const saved = localStorage.getItem('theme') ?? 
    (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
  document.documentElement.setAttribute('data-bs-theme', saved)

  toggle.addEventListener('click', () => {
    const current = document.documentElement.getAttribute('data-bs-theme')
    const next = current === 'dark' ? 'light' : 'dark'
    document.documentElement.setAttribute('data-bs-theme', next)
    localStorage.setItem('theme', next)
  })
})