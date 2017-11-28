import React from "react"
import ReactDOM from "react-dom"
import PropTypes from "prop-types"
import { Provider } from "react-redux"

import Watchdog from '../watchdog'
import configure from "../store"
import push from "../push"
import channels from "../channels"

store = configure()

store.dispatch(push.actions.service())
store.dispatch(channels.actions.fetch_channels())

document.addEventListener "DOMContentLoaded", ->
  $("content-body").html()

  ReactDOM.render(
    <Provider store={store}>
      <Watchdog/>
    </Provider>,
    document.getElementById("content-body"),
  )
