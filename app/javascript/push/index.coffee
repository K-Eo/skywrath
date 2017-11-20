debug = require("debug")("skywrath:notifications")

import Settings from "settings.js"
import Pusher from "pusher-js"

import alerts from "../watchdog/alerts"

getOptions = ->
  {
    encrypted: true
    cluster: "us2"
  }

getKey = ->
  Settings["pusher-key"]

debug "Starting Pusher"

pusher = null
channel = null

export start = (store) ->
  pusher = new Pusher getKey(), getOptions()
  channel = pusher.subscribe "alerts"

  pusher.connection.bind "error", (error) ->
    debug error

  pusher.connection.bind "state_change", (states) ->
    debug "pusher state: current '#{states.current}', previous: '#{states.previous}'"

  pusher.connection.bind "connecting_in", (delay) ->
    debug "Reconnection will happen in #{delay} seconds"

  channel.bind "new", (data) ->
    console.log(data)
    store.dispatch alerts.actions.add(data)

export default pusher
