export const showSpinner = () => {
  const el = document.getElementById('teik-spinner')
  if (el) el.classList.remove('d-none')
}

export const hideSpinner = () => {
  const el = document.getElementById('teik-spinner')
  if (el) el.classList.add('d-none')
}