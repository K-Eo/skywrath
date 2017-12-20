import React, { Component } from 'react'

import alerts from '../alerts'
import Map from '../maps/components/map'

const { AlertList } = alerts.components

class Watchdog extends Component {
  render () {
    return (
      <div className='row'>
        <AlertList />

        <div className='col-8'>
          <div className='card'>
            <div className='card-img-top'>
              <Map
                containerElement={<div style={{height: 400}} />}
                mapElement={<div style={{height: '100%'}} />}
              />
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Watchdog
