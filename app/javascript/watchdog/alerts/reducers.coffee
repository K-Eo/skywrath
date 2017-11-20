import { combineReducers } from "redux"
import * as types from "./types"

alerts = (state = {}, action) ->
  switch action.type
    when types.ADD
      Object.assign {}, state, { "#{action.data.id}": action.data }
    else
      state

create = (state = { status: "idle" }, action) ->
  switch action.type
    when types.CREATE_REQUEST
      Object.assign {}, state, { status: "requesting" }
    when types.CREATE_SUCCESS
      Object.assign {}, state, { status: "created" }
    when types.CREATE_FAILURE
      Object.assign {}, state, { status: "failed" }
    when types.CREATE_RESET
      Object.assign {}, state, { status: "idle" }
    else
      state

fetching = (state = { status: "idle", message: "" }, action) ->
  switch action.type
    when types.FETCH_REQUEST
      Object.assign {}, state, { status: "fetching", message: "" }
    when types.FETCH_SUCCESS
      Object.assign {}, state, { status: "success" }
    when types.FETCH_FAILURE
      Object.assign {}, state, { status: "failure", message: action.message }
    else
      state

control = combineReducers {
  create,
  fetching,
}

export {
  alerts as entities,
  control,
}
