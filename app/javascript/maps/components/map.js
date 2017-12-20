import React from 'react'
import { connect } from 'react-redux'
import { GoogleMap, Marker, withGoogleMap, InfoWindow } from 'react-google-maps'

import { usersLocations, focusSelector } from '../selectors'

const MapComponent = withGoogleMap(props => {
  console.log(props)
  return (
    <GoogleMap
      defaultZoom={15}
      defaultCenter={{lat: 17.2687499, lng: -97.6971386}}
      center={props.center}
    >
      {
        props.markers.map(marker => (
          <Marker
            key={marker.id}
            position={marker}
          />
        ))
      }
    </GoogleMap>
  )
})

const mapStateToProps = (state) => ({
  markers: usersLocations(state),
  center: focusSelector(state)
})

export default connect(mapStateToProps)(MapComponent)
