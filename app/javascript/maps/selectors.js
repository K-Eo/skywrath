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
  ({ target }, users) => {
    const defaultLocation = { lat: 17.2687499, lng: -97.6971386 }

    if (!target) {
      return defaultLocation
    }

    const user = users[target]

    if (user && user.lat && user.lng) {
      return {
        lat: user.lat,
        lng: user.lng
      }
    }

    return defaultLocation
  }
)
