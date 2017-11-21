import React from "react"
import { connect } from "react-redux"
import classNames from "classnames"

import alerts from "./alerts"

{ AlertList } = alerts.components

App = (props) ->
  { status } = props

  create_class = classNames {
    ui: true
    button: true
    positive: status == "success" || status == "idle" || status == "requesting"
    loading: status == "requesting"
    negative: status == "failure"
  }

  <div className="ui grid">
    <div className="sixteen wide column">
      <button className={create_class} onClick={props.create}>
        Nueva Alerta
      </button>
    </div>
    <AlertList/>
  </div>

mapStateToProps = (state) ->
  status: state.control.alerts.create.status

App = connect(mapStateToProps, alerts.actions)(App)

export default App
