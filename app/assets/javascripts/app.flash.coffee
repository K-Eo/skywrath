App.Flash =
  remove: (el) ->
    console.log "Removing flash message: #{el.className}"
    $(el).remove()

$(document).on "click", ".ui.message.closeable", (el) =>
  App.Flash.remove(el.currentTarget)
