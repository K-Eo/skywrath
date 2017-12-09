import React, { Component } from 'react'
import { GoogleMap, Marker, withGoogleMap } from 'react-google-maps'

import alerts from '../alerts'

const MapComponent = withGoogleMap((props) =>
  <GoogleMap
    defaultZoom={8}
    defaultCenter={{lat: -34.397, lng: 150.644}}
  >
    <Marker
      position={{lat: -34.397, lng: 150.644}}
    />
  </GoogleMap>
)

const { AlertList } = alerts.components

class Watchdog extends Component {
  render () {
    return (
      <div className='row'>
        <AlertList />

        <div className='col-8'>
          <div className='card'>
            <div className='card-img-top'>
              <MapComponent
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
