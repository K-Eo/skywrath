debug = require("debug")("skywrath:timing")
import timeago from "timeago.js/src/timeago"
import es from "timeago.js/locales/es"

class Timeago
  constructor: (@el) ->
    @el ||= "time.timeago"
    @registerLocale()

  render: ->
    debug "rendering with tag: #{@el}"
    timeago(null, @getLang()).render($(@el))

  cancel: ->
    debug "cancel rendering"
    timeago.cancel()

  getLang: ->
    $("html").attr("lang")

  registerLocale: ->
    debug "registering ES locale"
    timeago.register("es", es)

instance = new Timeago

$(document).on "turbolinks:before-visit", ->
  instance.cancel()

$(document).on "turbolinks:load", ->
  instance.render()
  $("#alerts").on "alert:add", (event, id) ->
    debug "alert:add event with id: #{id}"
    if id?
      debug "rendering time on id: #{id}"
      timeago().render($("#alert_#{id} time.timeago"), "es")
