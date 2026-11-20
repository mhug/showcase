import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

onDomContentLoaded('U+FFFC', () => {
  const teiText = document.querySelector('.tei-text')
  if (teiText) {
    const walker = document.createTreeWalker(teiText, NodeFilter.SHOW_TEXT, {
      acceptNode: node => node.nodeValue.includes("\uFFFC") ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP
    })

    const nodesToReplace = []
    while (walker.nextNode()) {
      nodesToReplace.push(walker.currentNode)
    }

    nodesToReplace.forEach(node => {
      const parent = node.parentNode
      node.nodeValue = node.nodeValue.replace(/\uFFFC/g, "")

      const icon = document.createElement("i")
      icon.className = "bi bi-question-diamond"
      icon.style.textIndent = 0
      icon.title = "U+FFFC: object replacement character"
      icon.setAttribute("data-bs-toggle", "tooltip")
      parent.insertBefore(icon, node.nextSibling)
    })
  }
  updateTooltips()
})