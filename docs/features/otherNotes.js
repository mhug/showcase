import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

onDomContentLoaded('other notes', () => {
  document.querySelectorAll(".tei-note:is([data-place='mTop'], [data-place='inline'], [data-place='mBottom'], [data-place='left'], [data-place='right'])").forEach(note => {
    const popoverId = `popover-${Math.random().toString(36).substr(2, 9)}`

    const icon = document.createElement("button")
    icon.className = "btn btn-link tei-note-icon"
    icon.innerHTML = "📜"
    icon.setAttribute("type", "button")
    icon.setAttribute("data-bs-toggle", "popover")
    icon.setAttribute("data-bs-title", `[note] place: ${note.getAttribute("data-place")}`)
    icon.setAttribute("data-bs-content", note.innerHTML)
    icon.setAttribute("id", popoverId)

    note.replaceWith(icon)

    const popover = new bootstrap.Popover(icon, {
      html: true, 
      container: "body",
      trigger: "manual"
    })
    
    icon.addEventListener('mouseenter', function() {
      popover.show()
      const popoverElement = document.querySelector('.popover')
      if (popoverElement) {
        popoverElement.addEventListener('mouseleave', () => {
          popover.hide()
        })
      }
    })

    icon.addEventListener('mouseleave', function() {
      setTimeout(() => {
        if (!document.querySelector('.popover:hover')) {
          popover.hide()
        }
      }, 300)
    })
  })
})