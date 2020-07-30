// Use link_to confirm: 'message'
// built into Rails

// // config
// const dataConfirm = 'data-confirm'

// // Make sure the DOM is loaded before we start manipulating it
// window.addEventListener('click', (event) => {
//   const clickTarget = event.target || event.srcElement

//   const confirmable = closestWith(dataConfirm, clickTarget)

//   // close button was not clicked
//   if (confirmable === null) return

//   alert(confirmable)
// })

// function closestWith(dataLabel, el) {
//   if (el === null) return null

//   // element has dataLabel applied
//   if (el.getAttribute(dataLabel) !== null) return el

//   // drill down one level
//   return closestWith(dataLabel, el.parentElement)
// }
