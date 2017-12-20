import React, { Component } from 'react'
import { connect } from 'react-redux'
import { GoogleMap, Marker, withGoogleMap, InfoWindow } from 'react-google-maps'

import { usersLocations, focusSelector } from '../selectors'

class MapComponent extends Component {
  componentDidUpdate (prevProps) {
    const { center } = this.props

    if (prevProps.center.date !== center.date) {
      this._map.panTo(center)
    }
  }

  render () {
    const { markers } = this.props
    return (
      <GoogleMap
        defaultZoom={15}
        defaultCenter={{lat: 17.2687499, lng: -97.6971386}}
        ref={(i) => this._map = i}
      >
        {
          markers.map(marker => (
            <Marker
              key={marker.id}
              position={marker}
            />
          ))
        }
      </GoogleMap>
    )
  }
}

const mapStateToProps = (state) => ({
  markers: usersLocations(state),
  center: focusSelector(state)
})

export default connect(mapStateToProps)(
  withGoogleMap(MapComponent)
)
