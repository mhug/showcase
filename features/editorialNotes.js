import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

onDomContentLoaded('<note type="editorial">', () => {
  const notes = document.querySelectorAll('.tei-note[data-type="editorial"]')
  if (!notes.length) return

  const modal = document.createElement('div')
  modal.id = 'teik-modal'
  modal.className = 'teik-modal'
  modal.style.display = 'none'
  modal.innerHTML = `
    <div class="teik-modal-content tei-note" data-type="editorial">
      <span id="teik-modal-close">&times;</span>
      <div id="teik-modal-body"></div>
    </div>
  `
  document.body.appendChild(modal)
  const modalBody = modal.querySelector('#teik-modal-body')
  const closeModal = modal.querySelector('#teik-modal-close')

  notes.forEach(note => {
    const infoIcon = document.createElement('i')
    infoIcon.className = 'bi bi-info-circle teik-info-icon'
    infoIcon.style.textIndent = 0
    note.style.display = 'none'
    note.insertAdjacentElement('afterend', infoIcon)
    infoIcon.addEventListener('click', () => {
      modalBody.innerHTML = note.innerHTML
      modal.style.display = 'flex'
    })
  })

  closeModal.addEventListener('click', () => modal.style.display = 'none')
  window.addEventListener('click', e => { if (e.target === modal) modal.style.display = 'none' })
})