import React from "react"
import ReactDOM from "react-dom"
import PropTypes from "prop-types"

import Watchdog from 'watchdog'

document.addEventListener "DOMContentLoaded", ->
  $("#watchdog").html()

  ReactDOM.render(
    <Watchdog/>,
    document.getElementById("watchdog"),
  )
