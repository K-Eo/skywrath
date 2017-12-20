import React, { Component } from 'react'

import alerts from '../alerts'
import Map from '../maps/components/map'

const { AlertList } = alerts.components

const styles = {
  height: 'calc(100vh - 72px)',
  top: 0,
  position: 'absolute',
  right: 0,
  width: 'calc(100% - 320px - 22px)'
}

class Watchdog extends Component {
  render () {
    return (
      <div style={{ position: 'relative' }}>
        <AlertList />

        <Map
          containerElement={<div style={styles} />}
          mapElement={<div style={{height: '100%'}} />}
        />
      </div>
    )
  }
}

export default Watchdog
