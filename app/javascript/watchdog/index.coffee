import React from "react"
import { connect } from "react-redux"
import classNames from "classnames"

import alerts from "../alerts"

{ AlertList } = alerts.components

App = (props) ->
  { status, page, fetching_status } = props

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
    <div className="sixteen wide column">
      <AlertList/>
    </div>
    <div className="sixteen wide column">
      { if fetching_status == "idle" || fetching_status == "fetching"
          <div className="ui active centered inline loader"/>
        else if fetching_status == "failure"
          <div className="ui negative message">
            <div className="header">
              {failure_message}
            </div>
          </div> }
      { if page != "" and (fetching_status == "success" or fetching_status == "failure")
          <button className="ui default button" onClick={=> props.fetching(page)}>
            Mostrar más
          </button> }
    </div>
  </div>

mapStateToProps = (state) ->
  fetching_status: state.control.alerts.fetching.status
  failure_message: state.control.alerts.fetching.message
  status: state.control.alerts.create.status
  page: state.control.alerts.fetching.next_page

App = connect(mapStateToProps, alerts.actions)(App)

export default App
