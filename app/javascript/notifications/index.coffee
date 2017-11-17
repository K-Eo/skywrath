debug = require("debug")("notifications")

import Settings from "../settings"
import Pusher from "pusher-js"

class Notifications
  start: ->
    debug "Starting Pusher"
    @pusher = new Pusher @getKey(), @getOptions()
    @pusher.subscribe "alerts"
    @pusher.bind "new", @new_alert
    debug "Notifications UP"

  new_alert: (data) ->
    console.log(data)

  getOptions: ->
    {
      encrypted: true
      cluster: "us2"
    }

  getKey: ->
    Settings["pusher-key"]

export default new Notifications

