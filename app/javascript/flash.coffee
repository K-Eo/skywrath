debug = require("debug")("skywrath:flash")

$(document).on "click", ".alert.js-closeable", (el) ->
  debug "remove flash message"
  $(el.currentTarget).remove()
