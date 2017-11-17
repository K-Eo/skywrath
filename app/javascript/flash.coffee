debug = require("debug")("flash")

class Flash
  remove: (el) =>
    currentTarget = el.currentTarget
    debug "Removing flash message on: #{currentTarget.className}"
    $(currentTarget).remove()

  start: ->
    $(document).on "click", ".ui.message.closeable", @remove
    debug "Flash UJS UP"

export default new Flash
