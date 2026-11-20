import { showSpinner, hideSpinner } from './spinner.js'

export const domContentLoadedHandlers = []

export const onDomContentLoaded = (name, fn) => {
  domContentLoadedHandlers.push({ name, fn })
}

export function runDomReady() {
  const run = async () => {
    const totalStart = performance.now()
    for (const { name, fn } of domContentLoadedHandlers) {
      const start = performance.now()
      try {
        showSpinner()
        await Promise.resolve(fn())
      } catch (err) {
        console.error(`Handler ${name} failed:`, err)
      } finally {
        hideSpinner()
      }
      console.log(`${name} took ${(performance.now() - start).toFixed(2)} ms`)
    }
    console.log(`All DOMContentLoaded handlers took ${(performance.now() - totalStart).toFixed(2)} ms`)
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', run)
  } else {
    run()
  }
}