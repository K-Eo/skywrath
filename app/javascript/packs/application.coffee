debug = require("debug")("skywrath:application")
import "../src/application"
import "../flash"
import "../timing"

$(document).on "turbolinks:load", ->
  $(".ui.dropdown").dropdown()
  debug "UI dropdown"
