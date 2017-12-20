import { combineReducers } from 'redux'
import * as types from './types'

export const selection = (state = null, action) => {
  switch (action.type) {
    case types.SELECT:
      return action.id
    default:
      return state
  }
}

export const control = combineReducers({
  selection: selection
})
