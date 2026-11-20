import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

onDomContentLoaded('toggle header', () => {
  const toggleHeaderButton = document.querySelector("#toggleTeiHeader")
  const div = document.querySelector(".tei-teiHeader")
  
  if ( !div ) {
    if ( toggleHeaderButton )
      toggleHeaderButton.classList.add("hidden")
    return
  }

  div.classList.add("hidden")

  toggleHeaderButton.addEventListener("click", () => {
    const oldIcon = bootstrap.Tooltip.getInstance("#toggleTeiHeader i")
    if (oldIcon)
      oldIcon.dispose()
    toggleHeaderButton.innerHTML = ""

    const icon = document.createElement("i")
    icon.classList.add("bi", "bi-card-heading")
    icon.setAttribute("data-bs-toggle", "tooltip")
    
    div.classList.toggle('hidden')
  
    if ( div.classList.contains("hidden") ) {
      toggleHeaderButton.classList.remove("btn-dark")
      toggleHeaderButton.classList.add("btn-light", "btn-outline-dark")
      icon.setAttribute("title", "show header")
    }
    else {
      toggleHeaderButton.classList.add("btn-dark")
      toggleHeaderButton.classList.remove("btn-light", "btn-outline-dark")
      icon.setAttribute("title", "hide header")

      const element = document.querySelector(".tei-teiHeader")
      if (element) {
        element.scrollIntoView({ behavior: "smooth" })
      }
    }
    toggleHeaderButton.appendChild(icon)
    updateTooltips()
  })
})