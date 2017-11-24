import React, { Component } from "react"
import { connect } from "react-redux"

import { Alert } from "./alert"
import * as actions from "../actions"
import { active_selector } from '../selectors'

class AlertList extends Component
  componentDidMount: ->
    @props.fetching()

  render: ->
    { alerts } = @props

    <div className="ui two stackable cards">
      { for i in alerts
          <Alert key={i.id} {i...} /> }
    </div>

mapStateToProps = (state) ->
  alerts: active_selector(state)

AlertList = connect(mapStateToProps, actions)(AlertList)

export {
  AlertList
}
