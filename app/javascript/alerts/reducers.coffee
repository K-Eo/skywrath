import _ from "lodash"
import { combineReducers } from "redux"
import * as types from "./types"

entities = (state = {}, action) ->
  switch action.type
    when "ADD"
      alerts = action.data.entities.alerts
      return state unless alerts?
      _.assign {}, state, alerts
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

fetching_state =
  status: "idle"
  message: ""
  next_page: ""

fetching = (state = fetching_state, action) ->
  switch action.type
    when types.FETCH_REQUEST
      _.assign {}, state, { status: "fetching", message: "" }
    when types.FETCH_SUCCESS
      _.assign {}, state, { status: "success", next_page: action.data["x-next-page"] }
    when types.FETCH_FAILURE
      _.assign {}, state, { status: "failure", message: action.message }
    else
      state

state_reducer = (state = { status: "success", message: "" }, action) ->
  switch action.type
    when types.STATE_CHANGE_REQUEST
      _.assign {}, state, { status: "requesting", message: "" }
    when types.STATE_CHANGE_SUCCESS
      _.assign {}, state, { status: "success" }
    when types.STATE_CHANGE_FAILURE
      _.assign {}, state, { status: "failure", message: action.message }
    else
      state

state_change = (state = {}, action) ->
  switch action.type
    when "ADD"
      alerts = action.data.entities.alerts
      return state unless alerts?
      items = _.mapValues action.data.entities.alerts, ->
        { status: "success", message: "" }
      _.assign {}, state, items
    when types.STATE_CHANGE_REQUEST, types.STATE_CHANGE_SUCCESS, types.STATE_CHANGE_FAILURE
      alert = state[action.id]
      return state unless alert?
      _.assign {}, state, { "#{action.id}": state_reducer(alert, action) }
    else
      state

control = combineReducers {
  create
  fetching
  state_change
}

export {
  entities
  control
}
