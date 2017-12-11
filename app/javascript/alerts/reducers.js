import _ from 'lodash'
import { combineReducers } from 'redux'
import * as types from './types'

export const entities = (state = {}, action) => {
  switch (action.type) {
    case 'ADD':
      if (action.entities && action.entities.alerts) {
        return _.assign({}, state, action.entities.alerts)
      }

      return state
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

const assignReducer = (state = { status: 'success', message: '' }, action) => {
  switch (action.type) {
    case types.ASSIGN_REQUEST:
      return _.assign({}, state, { status: 'requesting', message: '' })
    case types.ASSIGN_SUCCESS:
      return _.assign({}, state, { status: 'success' })
    case types.ASSIGN_FAILURE:
      return _.assign({}, state, { status: 'failure', message: action.message })
    default:
      return state
  }
}

const assignControl = (state = {}, action) => {
  switch (action.type) {
    case 'ADD':
      if (action.entities && action.entities.alerts) {
        let items = _.mapValues(
          action.entities.alerts,
          () => assignReducer(undefined, action)
        )

        return _.assign({}, state, items)
      }

      return state
    case types.ASSIGN_REQUEST:
    case types.ASSIGN_SUCCESS:
    case types.ASSIGN_FAILURE:
      const alert = state[action.id]

      if (alert) {
        return _.assign({}, state, { [action.id]: assignReducer(alert, action) })
      }

      return state
    default:
      return state
  }
}

export const control = combineReducers({
  assign: assignControl,
  fetching: fetchingControl
})
