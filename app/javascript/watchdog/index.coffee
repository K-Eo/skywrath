import React from "react"

import alerts from "./alerts"

{ AlertList } = alerts.components

App = (props) ->
  <div className="ui grid">
    <div className="sixteen wide column">
      <button className="ui positive button">
        Nueva Alerta
      </button>
    </div>
    <AlertList/>
  </div>

export default App
