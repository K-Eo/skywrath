import * as types from "./types"
import { normalize, arrayOf } from "normalizr"
import * as schemas from "./schemas"

add = (data) ->
  type: types.ADD
  data: data

add_bulk = (data) ->
  type: types.ADD_BULK
  data: data

fetchRequest = ->
  type: types.FETCH_REQUEST

fetchSuccess = ->
  type: types.FETCH_SUCCESS

fetchFailure = (message) ->
  type: types.FETCH_FAILURE
  message: message

export fetching = ->
  (dispatch, getState, axios) ->
    return if getState().control.alerts.fetching.status == "fetching"

    dispatch(fetchRequest())

    axios.get "/alerts"
      .then (response) ->
        throw Error("Can't fetch alerts") if response.status != 200
        response.data
      .then (data) ->
        dispatch(fetchSuccess())
        dispatch(add_bulk(normalize(data, [ schemas.alert ])))
      .catch (error) ->
        dispatch(fetchFailure(error.message))

createRequest = ->
  type: types.CREATE_REQUEST

createSuccess = ->
  type: types.CREATE_SUCCESS

createFailure = (message) ->
  type: types.CREATE_FAILURE
  message: message

createIdle = ->
  type: types.CREATE_RESET

export create = ->
  (dispatch, getState, axios) ->
    return if getState().control.alerts.create.status == "requesting"

    dispatch(createRequest())

    axios.post "/alerts"
      .then (response) ->
        throw Error(response.status) if response.status != 201
        dispatch(createSuccess())
      .catch (error) ->
        dispatch(createFailure(error.message))
