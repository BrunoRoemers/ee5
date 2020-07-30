// config
const filterFormId = 'filter-form'
const statusFilterId = 'filter-form-status'

// Make sure the DOM is loaded before we start manipulating it
window.addEventListener('turbolinks:load', (event) => {
  const filterForm = document.getElementById(filterFormId)
  const statusFilter = document.getElementById(statusFilterId)

  if (!statusFilter || !filterForm) return

  // hide form submit button
  filterForm
    .querySelector('[type=submit]')
    .classList.add("sr-only")

  // submit form when status changes
  statusFilter.addEventListener('change', (event) => {
    filterForm.submit()
  })
})
