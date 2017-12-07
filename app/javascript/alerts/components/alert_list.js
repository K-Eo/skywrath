import React, { Component } from "react"

import Alert from "./alert"

export class AlertList extends Component {
  constructor (props) {
    super(props)
    this.state = {
      alerts: [{ id: 1 }, { id: 2 }, { id: 3}]
    }
  }
  render () {
    const { alerts } = this.state

    return (
      <div className="five wide column">
        <div className="ui segments">
          {
            alerts.map(alert => (
              <Alert key={alert.id}/>
            ))
          }
        </div>
      </div>
    )
  }
}
