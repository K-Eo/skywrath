import React, { Component } from "react"

import alerts from "../alerts"
const { AlertList } = alerts.components

class Monitor extends Component {
  render () {
    return (
      <div className="ui grid">
        <AlertList/>

        <div className="eleven wide column">
          <div className="ui loading segment">
            Google Maps Placeholder
          </div>
        </div>
      </div>
    )
  }
}

export default Monitor
