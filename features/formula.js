import { onDomContentLoaded } from '../lib/domReady.js'

onDomContentLoaded('<formula>', () => {
  if (document.querySelector('.tei-formula[data-notation="TeX"]')) {
    let script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js'
    script.async = true
    document.head.appendChild(script)

    script.onload = function () {
      document.querySelectorAll('.tei-formula[data-notation="TeX"]').forEach(el => {
        el.innerHTML = '\\(' + el.innerHTML + '\\)'
      })
      MathJax.typeset()
    }
  }
})