export const debounce = (fn, wait = 150) => {
  let t = null
  return (...args) => {
    clearTimeout(t)
    t = setTimeout(() => fn(...args), wait)
  }
}

export const loadImage = src =>
  new Promise((resolve, reject) => {
    const img = new Image()
    img.onload = () => resolve(img)
    img.onerror = err => reject(err)
    img.src = src
  })

export const qsAll = (sel, ctx = document) => Array.from(ctx.querySelectorAll(sel))
export const qs = (sel, ctx = document) => ctx.querySelector(sel)