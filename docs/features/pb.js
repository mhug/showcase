import { onDomContentLoaded } from '../lib/domReady.js'
import { showSpinner, hideSpinner } from '../lib/spinner.js'
import { debounce } from '../lib/utils.js'
import { updateTooltips } from './tooltips.js'

let facsimilesShown = false

function pbSetTextContent(el) {
  el.innerHTML = ''
  const n = el.dataset.n
  const facs = el.dataset.facs
  const corresp = el.dataset.corresp

  if (facs) {
    const facsIsUrl = /^https?:\/\//.test(facs)
    let src = null
    if (facsIsUrl) {
      const isImage = /\.(png|jpe?g)$/i.test(facs)
      if (isImage) src = facs
    } else {
      const dtaDirname = document.querySelector(".tei-idno[data-type='DTADirName']")
      if (dtaDirname) {
        const dirname = dtaDirname.textContent.trim()
        if (dirname) src = `${window.dtaBase}media/images/${dirname}/${dirname}_${facs.replace(/^#f/, '')}_1600px.jpg`
      }
    }

    if (!src) {
      el.textContent = `[page ${n || '-'}]`
      return
    }
    else {
      document.getElementById('toggleFacsimiles')?.classList.remove('hidden')
    }

    el.id = facs.replace(/^#/, '')
    const aLink = document.createElement('a')
    aLink.textContent = `[page ${n || '-'}]`
    aLink.classList.add('spotlight')

    const facsLabel = /^https?:\/\//.test(facs) ? '' : facs
    aLink.setAttribute('data-title', `facsimile ${facsLabel}${n ? ' [' + n + ']' : ''}`)
    aLink.setAttribute('href', src)
    aLink.setAttribute('target', '_blank')
    aLink.setAttribute('title', 'show facsimile in full screen')
    aLink.setAttribute('data-bs-toggle', 'tooltip')
    el.appendChild(aLink)
    
    // start
    aLink.addEventListener('click', e => {
      console.log('Clicked on facsimile link:', aLink.href)
      e.preventDefault()
      const btn = document.querySelector('#toggleFacsimiles')
      if (!facsimilesShown) btn.click() // toggle gallery if not yet shown

      // trigger Spotlight on this link
      console.log(typeof Spotlight, aLink.classList.contains('spotlight'))
      if (aLink.classList.contains('spotlight')) {
        console.log('Triggering Spotlight for', aLink.href) 
        aLink.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }))
      }
    })
    // end

    if (!facsIsUrl) {
      const dirname = document.querySelector(".tei-idno[data-type='DTADirName']").textContent.trim()
      const dtaLink = document.createElement('a')
      dtaLink.style.marginLeft = '5px'
      dtaLink.textContent = 'DTA'
      dtaLink.setAttribute('href', `${window.dtaBase}/book/view/${dirname}?p=${facs.replace(/^#f0*/, '')}`)
      el.appendChild(dtaLink)
    }
  } else if (corresp) {
    const aLink = document.createElement('a')
    aLink.textContent = `[page ${n || '-'}]`
    aLink.setAttribute('href', corresp)
    el.appendChild(aLink)
  } else {
    el.textContent = `[page ${n || '-'}]`
  }
}

function simplePb() {
  document.querySelectorAll('.tei-pb[data-facs]').forEach(el => pbSetTextContent(el))
  updateTooltips()
}

function adjustHeights(facsFigures) {
  const pbElements = document.querySelectorAll('.tei-pb')
  facsFigures.forEach(({ figure, el }, i) => {
    const nextPb = pbElements[i + 1]
    if (!nextPb) return
    const pbRect = el.getBoundingClientRect()
    const nextPbRect = nextPb.getBoundingClientRect()
    const textHeight = nextPbRect.top - pbRect.bottom
    const figureHeight = figure.offsetHeight
    if (figureHeight > textHeight) {
      const spacer = document.createElement('div')
      spacer.classList.add('tei-pb-spacer')
      spacer.style.height = `${figureHeight - textHeight}px`
      nextPb.parentNode.insertBefore(spacer, nextPb)
    }
  })
}

async function showFacsimiles() {
  if (!facsimilesShown) return

  const dtaDirname = document.querySelector(".tei-idno[data-type='DTADirName']")
  const dirname = dtaDirname?.textContent.trim()
  const hasUrlFacs = Array.from(document.querySelectorAll('.tei-pb[data-facs]'))
    .some(el => /^https?:\/\//.test(el.dataset.facs))

  if (!dirname && !hasUrlFacs) return

  showSpinner()

  try {
    const facsFigures = []
    const tei = document.querySelector('.tei')
    const pbs = Array.from(document.querySelectorAll('.tei-pb[data-facs]'))

    const loads = pbs.map(async el => {
      el.innerHTML = ''
      pbSetTextContent(el)

      const textLink = el.querySelector('a')
      if (!textLink) return

      const n = el.dataset.n
      const facs = el.dataset.facs
      const facsIsUrl = /^https?:\/\//.test(facs)

      const src = facsIsUrl
        ? facs
        : `${window.dtaBase}media/images/${dirname}/${dirname}_${facs.replace(/^#f/, '')}_1600px.jpg`

      const srcThumb = facsIsUrl
        ? facs
        : `${window.dtaBase}media/images/${dirname}/${dirname}_${facs.replace(/^#f/, '')}_250px.jpg`

      textLink.classList.add('spotlight')
      textLink.setAttribute('href', src)

      const windowWidth = window.innerWidth
      const offset =
        windowWidth < 836 ? 160 :
        windowWidth < 1265 ? 220 :
        320

      const marginLeft = tei
        ? -(el.getBoundingClientRect().left - tei.getBoundingClientRect().left + offset)
        : 0

      const figure = document.createElement('figure')
      figure.classList.add('teik-side-figure')
      figure.style.marginLeft = `${marginLeft}px`

      const img = document.createElement('img')
      img.src = srcThumb
      img.classList.add('figure-img', 'img-fluid', 'rounded')

      img.addEventListener('click', () => {
        textLink.dispatchEvent(
          new MouseEvent('click', { bubbles: true, cancelable: true })
        )
      })

      const figCaption = document.createElement('figcaption')
      figCaption.classList.add('figure-caption')
      const facsLabel = /^https?:\/\//.test(facs) ? '' : facs
      figCaption.textContent = `facsimile ${facsLabel}${n ? ' [' + n + ']' : ''}`.trim()

      figure.appendChild(img)
      figure.appendChild(figCaption)
      el.appendChild(figure)

      facsFigures.push({ figure, el })

      await new Promise(resolve => {
        if (img.complete) resolve()
        else {
          img.onload = () => resolve()
          img.onerror = () => resolve()
        }
      })
    })

    await Promise.allSettled(loads)
    adjustHeights(facsFigures)
  } finally {
    hideSpinner()
    updateTooltips()
  }
}

function hideFacsimiles() {
  document.querySelectorAll('.tei-pb[data-facs]').forEach(el => { el.innerHTML = '' })
  document.querySelectorAll('.tei-pb-spacer').forEach(el => el.remove())
  simplePb()
}

onDomContentLoaded('simplePb', () => simplePb())

onDomContentLoaded('toggle images', () => {
  const btn = document.querySelector('#toggleFacsimiles')
  if (!btn) return
  const setIcon = (show) => {
    btn.innerHTML = ''
    const icon = document.createElement('i')
    icon.classList.add('bi', 'bi-file-richtext')
    icon.setAttribute('data-bs-toggle', 'tooltip')
    if (show) {
      btn.classList.add('btn-dark')
      btn.classList.remove('btn-light', 'btn-outline-dark')
      icon.setAttribute('title', 'hide facsimiles')
    } else {
      btn.classList.remove('btn-dark')
      btn.classList.add('btn-light', 'btn-outline-dark')
      icon.setAttribute('title', 'show facsimiles')
    }
    btn.appendChild(icon)
    updateTooltips()
  }

  setIcon(facsimilesShown)

  btn.addEventListener('click', () => {
    const oldTip = bootstrap?.Tooltip?.getInstance(btn.querySelector('i'))
    if (oldTip) oldTip.dispose()
    facsimilesShown = !facsimilesShown
    if (facsimilesShown) showFacsimiles()
    else hideFacsimiles()
    setIcon(facsimilesShown)
  })
})