import React from 'react'
import ReactDOM from 'react-dom'

const MOUNT_NODE = "content-body"

import Monitor from "../monitor/app"

document.addEventListener("turbolinks:load", () => {
  if (document.getElementsByClassName('alerts monitor').length == 0) {
    return
  }

  ReactDOM.render(
    <Monitor/>,
    document.getElementById(MOUNT_NODE))
})

document.addEventListener("turbolinks:before-cache", () => {
  ReactDOM.unmountComponentAtNode(
    document.getElementById(MOUNT_NODE)
  )
})
