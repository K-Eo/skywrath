import * as redux from "redux"
import thunk from "redux-thunk"
import reduxImmutable from "redux-immutable-state-invariant"
import axios from "axios"

axios.defaults.baseURL = "/api/v1"

import push_middleware from "./push_middleware"

import alerts from "../alerts"
import push from "../push"
import channels from "../channels"
import users from "../users"

globalState = {}

makeThunk = ->
  thunk.withExtraArgument(axios)

devTools = ->
  if window.devToolsExtension
    window.devToolsExtension()
  else
    (f) -> f

export configure = (initialState = globalState) ->
  entities = redux.combineReducers {
    alerts: alerts.reducers.entities
    users: users.reducers.entities
  }

  control = redux.combineReducers {
    alerts: alerts.reducers.control
    channels: channels.reducers.control
    push: push.reducers.control
  }

  reducer = redux.combineReducers {
    control
    entities
  }

  compose = null

  if process.env.NODE_ENV == "development"
    compose = redux.compose(
      redux.applyMiddleware(makeThunk(), push_middleware(), reduxImmutable()),
      devTools(),
    )
  else
    compose = redux.compose(redux.applyMiddleware(makeThunk(), push_middleware()))

  redux.createStore reducer, initialState, compose

export default configure
