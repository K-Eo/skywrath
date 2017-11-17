import React, { Component } from "react"

import Alert from "./alert"

class AlertList extends Component
  constructor: (props) ->
    super(props)
    @state =
      fetching: true
      alerts: []

  componentDidMount: ->
    fetch "/api/v1/alerts", { credentials: "same-origin" }
      .then (response) ->
        if response.ok
          response
        else
          throw Error("Network request failed")
      .then (response) ->
        response.json()
      .then (data) =>
        @setState { alerts: data, fetching: false }

  render: ->
    if @state.fetching
      <div>Loading</div>
    else
      <div className="ui three stackable cards">
        { for i in @state.alerts
            <Alert key={i.id} {i...} /> }
      </div>

export default AlertList
