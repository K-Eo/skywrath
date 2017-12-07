import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'

import configure from '../store'
import Monitor from '../monitor/app'

const MOUNT_NODE = 'content-body'
const store = configure()

document.addEventListener('turbolinks:load', () => {
  if (document.getElementsByClassName('alerts monitor').length === 0) {
    return
  }

  ReactDOM.render(
    <Provider store={store}>
      <Monitor />
    </Provider>,
    document.getElementById(MOUNT_NODE))
})

document.addEventListener('turbolinks:before-cache', () => {
  ReactDOM.unmountComponentAtNode(
    document.getElementById(MOUNT_NODE)
  )
})
