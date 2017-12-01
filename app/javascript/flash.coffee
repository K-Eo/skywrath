debug = require("debug")("skywrath:flash")

$(document).on "click", ".ui.message.closeable", (el) ->
  debug "remove flash message"
  $(el.currentTarget).remove()
