import axios from "axios"
import * as types from "./types"

add = (data) ->
  type: types.ADD
  data: data

fetchRequest = ->
  type: types.FETCH_REQUEST

fetchSuccess = ->
  type: types.FETCH_SUCCESS

fetchFailure = (message) ->
  type: types.FETCH_FAILURE
  message: message

export fetching = ->
  (dispatch, getState) ->
    return if getState().control.alerts.fetching.status == "fetching"

    dispatch(fetchRequest())

    axios.get "/api/v1/alerts"
      .then (response) ->
        throw Error("Can't fetch alerts") if response.status != 200
        response.data
      .then (data) ->
        dispatch(fetchSuccess())
        for item in data
          dispatch(add(item))
      .catch (error) ->
        dispatch(fetchFailure(error.message))

createRequest = ->
  type: types.CREATE_REQUEST

createSuccess = ->
  type: types.CREATE_SUCCESS

createFailure = ->
  type: types.CREATE_FAILURE

createIdle = ->
  type: types.CREATE_RESET

export create = ->
  (dispatch, getState) ->
    return if getState().control.alerts.create.status == "requesting"

    dispatch(createRequest())

    axios.post "/api/v1/alerts"
      .then (response) ->
        throw Error(response.status) if response.status != 201
        return response.data
      .then (data) ->
        dispatch(createSuccess())
        dispatch(add(data))
      .catch (error) ->
        dispatch(createFailure(error.message))
