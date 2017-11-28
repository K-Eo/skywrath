class Timeago
  constructor: (@el) ->
    @el ||= "time.timeago"
    @registerLocale()

  render: ->
    console.log "Timeago rendering with tag: #{@el}"
    timeago(null, @getLang()).render($(@el))

  cancel: ->
    console.log "Cancel timeago rendering"
    timeago.cancel()

  getLang: ->
    $("html").attr("lang")

  registerLocale: ->
    console.log "Registering ES locale for timeago"
    timeago.register("es", @locale)

  locale: (number, index) ->
    [ ["justo ahora", "en un rato"],
      ["hace %s segundos", "en %s segundos"],
      ["hace 1 minuto", "en 1 minuto"],
      ["hace %s minutos", "en %s minutos"],
      ["hace 1 hora", "en 1 hora"],
      ["hace %s horas", "en %s horas"],
      ["hace 1 día", "en 1 día"],
      ["hace %s días", "en %s días"],
      ["hace 1 semana", "en 1 semana"],
      ["hace %s semanas", "en %s semanas"],
      ["hace 1 mes", "en 1 mes"],
      ["hace %s meses", "en %s meses"],
      ["hace 1 año", "en 1 año"],
      ["hace %s años", "en %s años"]
    ][index]

$(document).ready ->
  App.Timeago = new Timeago
  App.Timeago.render()

$(document).on "turbolinks:before-visit", ->
  App.Timeago.cancel()

$(document).on "turbolinks:load", ->
  App.Timeago.render() if App.Timeago?
