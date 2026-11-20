import { onDomContentLoaded } from '../lib/domReady.js'
import { updateTooltips } from './tooltips.js'

const CONFIG = {
  tocId: 'teik-toc',
  tocParentSelector: '.content .container',
  toolsetSelector: '.teik-toolset',
  headSelector: '.tei-text .tei-head',
  excludedSelectors: ['.tei-note', '.tei-figure'],
  strippedChildSelectors: [
    '.tei-note',
    '.tei-choice > .tei-sic',
    '.tei-choice > .tei-orig',
    '.tei-choice > .tei-abbr',
  ],
  tocTitle: 'Table of contents',
  anchorPrefix: 'toc-head',
  toggleIconHtml: '<i class="bi bi-list-columns" title="toggle TOC" data-bs-toggle="tooltip"></i>',
  toggleButtonClass: 'btn btn-light btn-outline-dark',
  collapsedSymbol: '▸',
  expandedSymbol: '▼',
}

function createElement(tag, props = {}) {
  const el = document.createElement(tag)
  if (props.id)        el.id = props.id
  if (props.className) el.className = props.className
  if (props.innerHTML) el.innerHTML = props.innerHTML
  if (props.textContent !== undefined) el.textContent = props.textContent
  if (props.style)     Object.assign(el.style, props.style)
  if (props.dataset)   Object.assign(el.dataset, props.dataset)
  if (props.href)      el.href = props.href
  if (props.type)      el.setAttribute('type', props.type)
  return el
}

function getDivDepth(el) {
  let depth = 0
  let current = el.parentElement
  while (current) {
    if (current.classList?.contains('tei-div')) depth++
    current = current.parentElement
  }
  return depth
}

function cloneAndStripHead(head) {
  const clone = head.cloneNode(true)
  clone.querySelectorAll(CONFIG.strippedChildSelectors.join(', ')).forEach(n => n.remove())
  return clone
}

function isExcludedHead(head) {
  return CONFIG.excludedSelectors.some(sel => head.closest(sel))
}

function buildEntries(heads) {
  const entries = []

  heads.forEach((head, i) => {
    if (isExcludedHead(head)) return

    const anchorId = `${CONFIG.anchorPrefix}-${i}`
    head.id = anchorId

    const depth = getDivDepth(head)
    const clone = cloneAndStripHead(head)

    const link = createElement('a', {
      href: `#${anchorId}`,
      textContent: clone.textContent.trim(),
    })

    const entry = createElement('div', {
      style: { marginLeft: `${depth}em` },
      dataset: { depth, index: i },
    })
    entry.appendChild(link)

    entries.push({ depth, element: entry, children: [] })
  })

  return entries
}

function buildTree(entries) {
  entries.forEach((entry, i) => {
    const parent = [...entries.slice(0, i)].reverse().find(e => e.depth < entry.depth)
    if (parent) parent.children.push(entry)
  })
  return entries.filter(e => !entries.some(p => p.children.includes(e)))
}

function addToggleControl(entry) {
  const { element, children } = entry

  const toggle = createElement('span', {
    textContent: CONFIG.expandedSymbol,
    style: { cursor: 'pointer', marginLeft: '0.5em' },
  })

  toggle.addEventListener('click', () => {
    const isExpanded = toggle.textContent === CONFIG.collapsedSymbol
    toggle.textContent = isExpanded ? CONFIG.expandedSymbol : CONFIG.collapsedSymbol
    children.forEach(child => {
      child.element.style.display = isExpanded ? 'none' : 'block'
    })
  })

  element.appendChild(toggle)
}

function renderEntry(entry, container) {
  const { depth, element, children } = entry
  const hasCollapsibleChildren = depth > 1 && children.length > 0

  if (hasCollapsibleChildren) {
    addToggleControl(entry)
  }

  container.appendChild(element)

  children.forEach(child => {
    if (depth > 1) child.element.style.display = 'none'
    renderEntry(child, container)
  })
}

onDomContentLoaded('TOC', () => {
  const tocContainer = createElement('div', {
    id: CONFIG.tocId,
    className: 'bg-light',
    style: { display: 'none' },
  })
  document.querySelector(CONFIG.tocParentSelector).appendChild(tocContainer)

  const toggleButton = createElement('button', {
    type: 'button',
    innerHTML: CONFIG.toggleIconHtml,
    className: CONFIG.toggleButtonClass,
  })
  const toolset = document.querySelector(CONFIG.toolsetSelector)
  if (toolset) {
    toolset.prepend(toggleButton)
  } else {
    tocContainer.appendChild(toggleButton)
  }
  updateTooltips()

  const tocContent = createElement('div', { style: { display: 'none' } })
  tocContainer.appendChild(tocContent)

  const tocTitle = createElement('p', { textContent: CONFIG.tocTitle })
  tocTitle.style.fontWeight = 'bold'
  tocContainer.appendChild(tocTitle)

  toggleButton.addEventListener('click', () => {
    tocContainer.style.display = tocContainer.style.display === 'none' ? 'block' : 'none'
    if ( toolset )
      toolset.style.zIndex = tocContainer.style.display === 'none' ? 0 : 9999
    console.log(toolset.style.zIndex)
  })

  const heads = document.querySelectorAll(CONFIG.headSelector)
  const entries = buildEntries(heads)
  const roots = buildTree(entries)
  roots.forEach(entry => renderEntry(entry, tocContainer))
})