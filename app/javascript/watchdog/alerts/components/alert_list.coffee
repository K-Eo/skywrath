import React, { Component } from "react"
import { connect } from "react-redux"

import { Alert } from "./alert"
import * as actions from "../actions"
import { chunck_selector } from '../selectors'

class AlertList extends Component
  componentDidMount: ->
    @props.fetching()

  render: ->
    { alerts, failure_message, fetching_status } = @props

    if fetching_status == "idle" || fetching_status == "loading"
      <div>Loading</div>
    else if fetching_status == "failure"
      <div>{failure_message}</div>
    else
      <div className="ui three stackable cards">
        { for i in alerts
            <Alert key={i.id} {i...} /> }
      </div>

mapStateToProps = (state) ->
  fetching_status: state.control.alerts.fetching.status
  failure_message: state.control.alerts.fetching.message
  alerts: chunck_selector(state)

AlertList = connect(mapStateToProps, actions)(AlertList)

export {
  AlertList
}
