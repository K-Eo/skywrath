const debug = require("debug")("skywrath:notifications")

import Settings from "settings.js"
import Pusher from "pusher-js"

class Notifications {
  start() {
    debug("Starting Pusher")
    this.pusher = new Pusher(this.getKey(), this.getOptions())
    this.pusher.subscribe("alerts")
    this.pusher.bind("new", this.new_alert)
    debug("Notifications UP")
  }

  new_alert(data) {
    console.log(data)
  }

  getOptions() {
    return {
      encrypted: true,
      cluster: "us2",
    }
  }

  getKey() {
    return Settings["pusher-key"]
  }
}

export default new Notifications()
