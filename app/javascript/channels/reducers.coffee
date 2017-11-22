import _ from "lodash"
import { combineReducers } from "redux"

import * as types from "./types"

fetching = (state = { status: "idle", message: "" }, action) ->
  switch  action.type
    when types.FETCH_REQUEST
      _.assign {}, state, { status: "fetching", message: "" }
    when types.FETCH_SUCCESS
      _.assign {}, state, { status: "success" }
    when types.FETCH_FAILURE
      _.assign {}, state, { status: "failure", message: action.message }
    else
      state

items = (state = {}, action) ->
  switch action.type
    when types.ADD
      _.assign {}, state, { "#{action.data}": true }
    when types.REMOVE
      state
    else
      state

control = combineReducers {
  fetching
  items
}

export {
  control
}
