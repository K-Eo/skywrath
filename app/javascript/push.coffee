debug = require("debug")("skywrath:pusher")

import Pusher from "pusher-js"
import settings from "./settings"

getKey = ->
  settings["pusher-key"]

buildSettings = ->
  encrypted: true
  cluster: "mt1"

debug "Starting Pusher with key: %s and settings: %o", getKey(), buildSettings()

instance = new Pusher getKey(), buildSettings()

instance.connection.bind "state_change", ({ previous, current }) ->
  debug "state change: %s -> %s", previous, current


export default instance
