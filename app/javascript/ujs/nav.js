const $ = window.$

$(document).on('turbolinks:load', () => {
  $('#js-user-links').dropdown()
})

$(document).on('turbolinks:before-cache', () => {
  $('#js-user-links').dropdown('destroy')
})
