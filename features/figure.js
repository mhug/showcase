import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('<figure>', () => {
  document.querySelectorAll('.tei-figure').forEach(teiFigure => {
    const figure = document.createElement('figure')
    figure.classList.add('tei-figure')
    Array.from(teiFigure.attributes).forEach(attr => {
      if (attr.name.startsWith('data-')) figure.setAttribute(attr.name, attr.value)
    })
    const facsSrc = teiFigure.dataset.facs
    if (facsSrc) {
      const img = document.createElement('img')
      img.src = facsSrc
      img.alt = 'Figure'
      img.classList.add('img-fluid')
      figure.appendChild(img)
    }
    const content = teiFigure.innerHTML.trim()
    const figCaption = document.createElement('figcaption')
    figCaption.innerHTML = content || '[figure]'
    figure.appendChild(figCaption)
    teiFigure.replaceWith(figure)
  })
})