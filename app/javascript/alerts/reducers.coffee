import _ from "lodash"
import { combineReducers } from "redux"
import * as types from "./types"

control_init = (state, action) ->
  alerts = action.data.entities.alerts
  return state unless alerts?
  items = _.mapValues alerts, ->
    { status: "success", message: "" }
  _.assign {}, state, items

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

close_reducer = (state, action) ->
  switch action.type
    when types.CLOSE_REQUEST
      _.assign {}, state, { status: "requesting", message: "" }
    when types.CLOSE_SUCCESS
      _.assign {}, state, { status: "success" }
    when types.CLOSE_FAILURE
      _.assign {}, state, { status: "failure", message: action.message }
    else
      state

close = (state = {}, action) ->
  switch action.type
    when "ADD"
      control_init(state, action)
    when types.CLOSE_REQUEST
      , types.CLOSE_SUCCESS
      , types.CLOSE_FAILURE
        alert = state[action.id]
        return state unless alert?
        _.assign {}, state, { "#{action.id}": close_reducer(alert, action) }
    else
      state

assignee_reducer = (state, action) ->
  switch action.type
    when types.ASSIGN_REQUEST
      _.assign {}, state, { status: "requesting", message: "" }
    when types.ASSIGN_SUCCESS
      _.assign {}, state, { status: "success" }
    when types.ASSIGN_FAILURE
      _.assign {}, state, { status: "failure", message: action.message }
    else
      state

assignee = (state = {}, action) ->
  switch action.type
    when "ADD"
      control_init(state, action)
    when types.ASSIGN_REQUEST
      , types.ASSIGN_SUCCESS
      , types.ASSIGN_FAILURE
        alert = state[action.id]
        return state unless alert?
        _.assign {}, state, { "#{action.id}": assignee_reducer(alert, action) }
    else
      state

control = combineReducers {
  create
  fetching
  close
  assignee
}

export {
  entities
  control
}
