App.Flash =
  remove: (el) ->
    console.log "Removing flash message: #{el.className}"
    $(el).remove()

$(document).on "click", ".ui.message", (el) =>
  App.Flash.remove(el.currentTarget)
