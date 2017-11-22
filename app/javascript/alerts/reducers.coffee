import _ from "lodash"
import { combineReducers } from "redux"
import * as types from "./types"

entities = (state = {}, action) ->
  switch action.type
    when types.ADD_BULK
      _.assign {}, state, action.data.entities.alerts
    when types.ADD
      _.assign {}, state, { "#{action.data.id}": action.data }
    else
      state

create = (state = { status: "idle" }, action) ->
  switch action.type
    when types.CREATE_REQUEST
      _.assign {}, state, { status: "requesting" }
    when types.CREATE_SUCCESS
      _.assign {}, state, { status: "success" }
    when types.CREATE_FAILURE
      _.assign {}, state, { status: "failure" }
    when types.CREATE_RESET
      _.assign {}, state, { status: "idle" }
    else
      state

fetching = (state = { status: "idle", message: "" }, action) ->
  switch action.type
    when types.FETCH_REQUEST
      _.assign {}, state, { status: "fetching", message: "" }
    when types.FETCH_SUCCESS
      _.assign {}, state, { status: "success" }
    when types.FETCH_FAILURE
      _.assign {}, state, { status: "failure", message: action.message }
    else
      state

control = combineReducers {
  create,
  fetching,
}

export {
  entities
  control
}
