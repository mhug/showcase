import { onDomContentLoaded } from '../lib/domReady.js'

export function updateTooltips () {
  const tooltipElements = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  if (window.tippy) {
    tippy(tooltipElements, { content: el => el.getAttribute('title') })
  } else if (window.bootstrap && tooltipElements.length) {
    tooltipElements.forEach(el => new bootstrap.Tooltip(el))
  }
  tooltipElements.forEach(el => el.removeAttribute('title'))
}

onDomContentLoaded('update tooltips', () => {
  updateTooltips()
})

