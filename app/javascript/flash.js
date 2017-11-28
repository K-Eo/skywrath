const debug = require("debug")("skywrath:flash")

class Flash {
  remove(el) {
    const currentTarget = el.currentTarget
    debug(`Removing flash message on: ${currentTarget.className}`)
    $(currentTarget).remove()
  }

  start() {
    $(document).on("click", ".ui.message.closeable", this.remove.bind(this))
    debug("Flash UJS UP")
  }
}

export default new Flash()
