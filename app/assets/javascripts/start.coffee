$(document).on "turbolinks:load", ->
  $(".ui.dropdown").dropdown();
  new App.Notifications
  new App.Timeago
