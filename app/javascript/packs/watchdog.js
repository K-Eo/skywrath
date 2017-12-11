import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'

import configure from '../store'
import Watchdog from '../watchdog/app'
import alertsPush from '../alerts/push'

const debug = require('debug')('skywrath:watchdog')
const MOUNT_NODE = 'content-body'

const store = configure()

alertsPush(store)

const unmountWatchdog = () => {
  debug('unmounting watchdog react app')

  ReactDOM.unmountComponentAtNode(
    document.getElementById(MOUNT_NODE)
  )

  document.removeEventListener('turbolinks:before-cache', unmountWatchdog)
}

document.addEventListener('turbolinks:load', () => {
  debug('attemp to mount watchdog react app')

  const matches = document.getElementsByClassName('alerts watchdog')

  if (matches.length <= 0) {
    debug('skipping watchdog react app: .alerts.watchdog not found')
    return
  }

  debug('mounting watchdog react app')

  ReactDOM.render(
    <Provider store={store}>
      <Watchdog />
    </Provider>,
    document.getElementById(MOUNT_NODE),
    () => document.addEventListener('turbolinks:before-cache', unmountWatchdog)
  )
})
