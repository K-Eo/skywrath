import _ from 'lodash'
import { combineReducers } from 'redux'
import * as types from './types'

export const entities = (state = {}, action) => {
  switch (action.type) {
    case 'ADD':
      let alerts = action.data.entities.alerts

      if (alerts === null && alerts === undefined) {
        return state
      }

      return _.assign({}, state, alerts)
    default:
      return state
  }
}

const fetchingControl = (state = { status: 'success' }, action) => {
  switch (action.type) {
    case types.FETCH_REQUEST:
      return _.assign({}, state, { status: 'fetching', error: '' })
    case types.FETCH_SUCCESS:
      return _.assign({}, state, { status: 'success' })
    case types.FETCH_FAILURE:
      return _.assign({}, state, { status: 'failure', error: action.message })
    default:
      return state
  }
}

export const control = combineReducers({
  fetching: fetchingControl
})
