import { combineReducers } from 'redux'
import * as types from './types'

export const selection = (state = { target: null, date: null }, action) => {
  switch (action.type) {
    case types.SELECT:
      return {
        target: action.id,
        date: Date.now()
      }
    default:
      return state
  }
}

export const control = combineReducers({
  selection: selection
})
