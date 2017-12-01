debug = require("debug")("skywrath:pusher")

import Pusher from "pusher-js"
import settings from "./settings.coffee"

getKey = ->
  settings["pusher-key"]

buildSettings = ->
  cluster: "us2"
  encrypted: true

debug "Starting Pusher with key: %s and settings: %o", getKey(), buildSettings()
console.log getKey()

instance = new Pusher getKey(), buildSettings()

instance.connection.bind "state_change", ({ previous, current }) ->
  debug "state change: %s -> %s", previous, current


export default instance
