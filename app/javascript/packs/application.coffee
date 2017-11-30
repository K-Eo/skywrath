debug = require("debug")("skywrath:application")
import "../flash"
import "../timing"

# Notifications
import "../push/alerts"

$(document).on "turbolinks:load", ->
  $(".ui.dropdown").dropdown()
  debug "UI dropdown"
