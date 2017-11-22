import _ from "lodash"
import { combineReducers } from "redux"

import * as types from "./types"

state = (state = { state: "idle" }, action) ->
  switch action.type
    when types.STATUS
      _.assign {}, state, { state: action.data }
    else
      state

control = combineReducers {
  state
}

export {
  control
}
