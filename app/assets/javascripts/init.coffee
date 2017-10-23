window.App ||= {}

App.init = ->
  $(".ui.dropdown").dropdown();

$(document).on "turbolinks:load", ->
  App.init()
