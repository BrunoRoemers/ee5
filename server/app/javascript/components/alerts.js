// Usage
// add data-close-alert="<alert-id>" to the close button
// clicking on the close button (or any of its children) will close the alert

// config
const alertWrapperId = 'alert-wrapper'
const dataCloseAlert = 'data-close-alert'

// Make sure the DOM is loaded before we start manipulating it
window.addEventListener('turbolinks:load', (event) => {
  const alerts = document.getElementById(alertWrapperId)

  alerts && alerts.addEventListener('click', (event) => {
    const clickTarget = event.target || event.srcElement
    const closeBtn = closestWith(dataCloseAlert, clickTarget)

    // close button was not clicked
    if (closeBtn === null) return

    const alertId = closeBtn.getAttribute(dataCloseAlert)
    const alert = document.getElementById(alertId)

    // alert not found
    if (alert === null) {
      console.error(`Error: could not find alert with id "${alertId}"`)
      return
    }

    // remove alert from DOM
    alert.parentElement.removeChild(alert)
  })
})

function closestWith(dataLabel, el) {
  if (el === null) return null

  // element has dataLabel applied
  if (el.getAttribute(dataLabel) !== null) return el

  // drill down one level
  return closestWith(dataLabel, el.parentElement)
}
