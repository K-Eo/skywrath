debug = require("debug")("skywrath:push:alerts")
import push from "../push"

class Alerts
  channel_name: "alerts"
  channel: null

  constructor: (@push) ->

  getOrigin: ->
    $("body").data "origin"

  can_run: ->
    $(".alerts.index").length > 0

  can_run_event: (data) ->
    if not data? and not data.origin?
      debug "can't run event because no origin especified"
      return false

    @getOrigin() != data.origin

  destroy: ->
    return unless @can_run()

    debug "unsubscribe to channel: #{@channel_name}"
    @push.unsubscribe @channel_name

  start: ->
    return unless @can_run()

    debug "subscribe to channel: #{@channel_name}"
    @channel = @push.subscribe @channel_name

    debug "bind to new"
    @channel.bind "new", @new_event

    debug "bind to assignee"
    @channel.bind "assignee", @assignee_event

  trigger_timeago: (id) ->
    $("#alerts").trigger("alert:add", [id])

  assignee_event: (data) =>
    return unless @can_run_event(data)

    debug "assignee event on alert: #{data.id}"
    $("#alert_#{data.id}").replaceWith data.html
    @trigger_timeago(data.id)

  new_event: (data) =>
    return unless @can_run_event(data)

    debug "new alert with id: #{data.id}"
    $("#alerts").prepend data.html
    @trigger_timeago(data.id)

instance = new Alerts(push)

$(document).on "turbolinks:before-visit", ->
  instance.destroy()

$(document).on "turbolinks:load", ->
  instance.start()
