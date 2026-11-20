import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('<note place="foot"> | <note type="footnote">', () => {
  const textDiv = document.querySelector(".tei-text")
  
  const allFootnotes = document.querySelectorAll('.tei-note[data-place="foot"], .tei-note[data-type="footnote"]')

  // except footnotes in footnotes
  const footnotes = Array.from(allFootnotes).filter(note => 
    !note.closest('.tei-note:not(:scope)')
  )
  let footnoteCounter = 1

  footnotes.forEach(footnote => {
    let footnoteNumber = footnote.dataset.n
    if (!footnoteNumber)
      footnoteNumber = footnoteCounter.toString()

    const footnoteId = "footnote-" + footnoteCounter
    const anchorId = "anchor-" + footnoteCounter

    // replace footnote sign in text
    const anchor = document.createElement("a")
    anchor.href = "#" + footnoteId
    anchor.id = anchorId
    anchor.textContent = footnoteNumber
    anchor.classList.add("tei-footnote-sign")
    footnote.replaceWith(anchor)

    // insert footnote before next <pb> or at end of <div class="tei-text">
    const footnoteDiv = document.createElement('div')
    footnoteDiv.id = footnoteId
    footnoteDiv.classList.add("tei-footnote-text")
    footnoteDiv.innerHTML = `<a href="#${anchorId}" class="tei-footnote-sign">${footnoteNumber}</a> ${footnote.innerHTML}`

    const line = document.createElement("div")
    line.classList.add("tei-footnote-line")
    footnoteDiv.insertBefore(line, footnoteDiv.firstChild)

    // find next tei-pb
    const getPreviousNode = node => {
      if (node.previousSibling)
        return node.previousSibling
      let parent = node.parentNode
      while (parent && !parent.previousSibling) {
        if (parent === document.body)
          return null
        parent = parent.parentNode
      }
      return parent ? parent.previousSibling : null
    }
    
    const findNextPb = startNode => {
      let currentNode = startNode

      while (currentNode) {
        if (currentNode.firstChild) {
          currentNode = currentNode.firstChild
        }
        else {
          while (currentNode) {
            if (currentNode.nextSibling) {
              currentNode = currentNode.nextSibling
              break
            }
            currentNode = currentNode.parentNode
            if (currentNode === document.body)
              return null
          }
        }

        if (currentNode && currentNode.nodeType === Node.ELEMENT_NODE && currentNode.tagName === "SPAN" && currentNode.classList.contains("tei-pb"))
          return currentNode
      }

      return null
    }
    
    const previousNode = getPreviousNode(anchor)
    let nextPb = findNextPb(previousNode)

    if (!nextPb) {
      nextPb = findNextPb(textDiv)
    }

    if (nextPb) {
      nextPb.parentNode.insertBefore(footnoteDiv, nextPb)
    }
    else {
      textDiv.appendChild(footnoteDiv)
    }
    footnoteCounter++
  })
  
  // footnotes in notes
  const nestedFootnotes = Array.from(allFootnotes).filter(note => 
    note.closest('.tei-note:not(:scope)')
  )
  
  nestedFootnotes.forEach(footnote => {
    let footnoteNumber = footnote.dataset.n
    if (!footnoteNumber)
      footnoteNumber = footnoteCounter.toString()

    const footnoteId = "footnote-" + footnoteCounter
    const anchorId = "anchor-" + footnoteCounter

    // replace footnote sign in text
    const anchor = document.createElement("a")
    anchor.href = "#" + footnoteId
    anchor.id = anchorId
    anchor.textContent = footnoteNumber
    anchor.classList.add("tei-footnote-sign")
    footnote.replaceWith(anchor)

    // insert footnote at end of ancestor <note place="foot">/<note type="footnote">
    const footnoteDiv = document.createElement('div')
    footnoteDiv.id = footnoteId
    footnoteDiv.classList.add("tei-footnote-text")
    footnoteDiv.innerHTML = `<a href="#${anchorId}" class="tei-footnote-sign">${footnoteNumber}</a> ${footnote.innerHTML}`

    const line = document.createElement("div")
    line.classList.add("tei-footnote-line")
    footnoteDiv.insertBefore(line, footnoteDiv.firstChild)

    // find ancestor <note>
    const parentFootnote = footnote.closest('.tei-note')
    console.log(parentFootnote)
    if (parentFootnote === footnote) {
      // It's the element itself, not a real ancestor
      return
    }

    parentFootnote.appendChild(footnoteDiv)
    footnoteCounter++
  })
})