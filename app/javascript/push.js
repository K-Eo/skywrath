const debug = require("debug")("skywrath:pusher")

import Pusher from "pusher-js"
import settings from "./settings"

const getKey = () => settings["pusher-key"]

const buildSettings = () => ({
  cluster: "mt1",
  encrypted: true
})

debug(
  "Starting Pusher with key: %s and settings: %o",
  getKey(),
  buildSettings()
)

const instance = new Pusher(getKey(), buildSettings())

instance.connection.bind("state_change", ({ previous, current }) => {
  debug("state change: %s -> %s", previous, current)
})

export default instance
