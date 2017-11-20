import * as redux from "redux"
import thunk from "redux-thunk"
import reduxImmutable from "redux-immutable-state-invariant"

import alerts from "../alerts"

globalState = {}

devTools = ->
  if window.devToolsExtension
    window.devToolsExtension()
  else
    (f) -> f

export configure = (initialState = globalState) ->
  entities = redux.combineReducers {
    alerts: alerts.reducers.entities,
  }

  control = redux.combineReducers {
    alerts: alerts.reducers.control,
  }

  reducer = redux.combineReducers {
    entities,
    control,
  }

  compose = null

  if process.env.NODE_ENV == "development"
    compose = redux.compose(
      redux.applyMiddleware(thunk, reduxImmutable()),
      devTools(),
    )
  else
    compose = redux.compose(redux.applyMiddleware(thunk))

  redux.createStore reducer, initialState, compose

export default configure
