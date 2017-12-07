import * as redux from 'redux'
import thunk from 'redux-thunk'
import reduxImmutable from 'redux-immutable-state-invariant'
import axios from 'axios'

import alerts from '../alerts'
import users from '../users'

axios.defaults.baseURL = '/api/v1'

const makeThunk = () => thunk.withExtraArgument(axios)

const devTools = () => {
  if (window.devToolsExtension) {
    return window.devToolsExtension()
  } else {
    return (f) => f
  }
}

const globalState = {}

export const configure = (initialState = globalState) => {
  const entities = redux.combineReducers({
    alerts: alerts.reducers.entities,
    users: users.reducers.entities
  })

  const control = redux.combineReducers({
    alerts: alerts.reducers.control
  })

  const reducer = redux.combineReducers({
    control,
    entities
  })

  let compose = null

  if (process.env.NODE_ENV === 'development') {
    compose = redux.compose(
      redux.applyMiddleware(makeThunk(), reduxImmutable()),
      devTools()
    )
  } else {
    compose = redux.compose(
      redux.applyMiddleware(makeThunk())
    )
  }

  return redux.createStore(reducer, initialState, compose)
}

export default configure
