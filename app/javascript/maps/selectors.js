import _ from 'lodash'
import { createSelector } from 'reselect'

const usersSelector = (state) => state.entities.users
const selectionSelector = (state) => state.control.maps.selection

export const usersLocations = createSelector(
  usersSelector,
  (users) => _.map(users, (user) => ({ id: user.id, lat: user.lat, lng: user.lng }))
)

export const focusSelector = createSelector(
  selectionSelector,
  usersSelector,
  (id, users) => {
    const defaultLocation = { lat: 17.2687499, lng: -97.6971386 }

    if (!id) {
      return defaultLocation
    }

    const user = users[id]

    if (user && user.lat && user.lng) {
      return {
        lat: users[id].lat,
        lng: users[id].lng
      }
    }

    return defaultLocation
  }
)
