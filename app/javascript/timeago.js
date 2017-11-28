const debug = require("debug")("skywrath:timeago")

import timeago from "timeago.js/dist/timeago"
import es from "timeago.js/locales/es"

class Timeago {
  start(el) {
    this.el = el || ".timeago"
    this.registerLocale()
    debug(`Timeago will be rendered on tags with: ${this.el}`)
    timeago(null, this.getLang()).render($(this.el))
    debug("Timeago UP")
  }

  getLang() {
    return $("html").attr("lang")
  }

  registerLocale() {
    debug("Registering ES locale for timeago")
    timeago.register("es", es)
  }
}

export default new Timeago()
