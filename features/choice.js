import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('<choice>', () => {
  const choicePairs = [
    ['tei-abbr', 'tei-expan', 'expansion'],
    ['tei-reg', 'tei-orig', 'original'],
    ['tei-corr', 'tei-sic', 'apparent error']
  ]
  const placements = ['left', 'top', 'right', 'bottom']

  const getChoiceDepth = el => {
    let depth = 0
    let current = el.parentElement
    while (current) {
      if (current.classList && current.classList.contains('tei-choice')) depth++
      current = current.parentElement
    }
    return depth
  }

  const processChoice = choiceEl => {
    const depth = getChoiceDepth(choiceEl)
    const placement = placements[depth % placements.length]

    for (const [mainClass, altClass, label] of choicePairs) {
      const main = choiceEl.querySelector(`.${mainClass}`)
      const alt = choiceEl.querySelector(`.${altClass}`)
      if (!main || !alt) continue

      const tooltipContent = document.createElement('div')
      const hint = document.createElement('div')
      hint.textContent = label + ':'
      hint.style.fontWeight = 'bold'
      hint.style.marginBottom = '0.25em'
      const contentWrapper = document.createElement('div')
      contentWrapper.textContent = alt.textContent

      tooltipContent.appendChild(hint)
      tooltipContent.appendChild(contentWrapper)
      alt.style.display = 'none'

      if (window.tippy) {
        tippy(main, {
          content: tooltipContent,
          allowHTML: true,
          interactive: true,
          appendTo: document.body,
          placement,
          maxWidth: 'none'
        })
      } else if (window.bootstrap) {
        main.setAttribute('title', `${label}: ${alt.textContent}`)
        main.setAttribute('data-bs-toggle', 'tooltip')
        new bootstrap.Tooltip(main)
      }
    }

    choiceEl.querySelectorAll(':scope .tei-choice').forEach(child => {
      if (child !== choiceEl) processChoice(child)
    })
  }

  document.querySelectorAll('.tei-choice').forEach(processChoice)
})