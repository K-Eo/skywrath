import React from "react"
import ReactDOM from "react-dom"
import PropTypes from "prop-types"
import { Provider } from "react-redux"

import { start } from '../push'
import Watchdog from '../watchdog'
import configure from "../watchdog/store"

store = configure()
start(store)

document.addEventListener "DOMContentLoaded", ->
  $("content-body").html()

  ReactDOM.render(
    <Provider store={store}>
      <Watchdog/>
    </Provider>,
    document.getElementById("content-body"),
  )
