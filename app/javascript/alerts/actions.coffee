import * as types from "./types"
import { normalize, arrayOf } from "normalizr"
import * as schemas from "./schemas"

add = (data) ->
  type: "ADD"
  data: data

fetchRequest = ->
  type: types.FETCH_REQUEST

fetchSuccess = (data) ->
  type: types.FETCH_SUCCESS
  data: data

fetchFailure = (message) ->
  type: types.FETCH_FAILURE
  message: message

assign_request = (id) ->
  type: types.ASSIGN_REQUEST
  id: id

assign_success = (id) ->
  type: types.ASSIGN_SUCCESS
  id: id

assign_failure = (id, message) ->
  type: types.ASSIGN_FAILURE
  id: id
  message: message

can_assign = (id, getState) ->
  state = getState().control.alerts.assignee[id]
  state? and state.status != "requesting"

export assign = (id) ->
  (dispatch, getState, axios) ->
    return unless can_assign(id, getState)

    dispatch assign_request(id)

    axios.post "/alerts/#{id}/assign"
      .then (response) ->
        throw Error("Can't assign to alert") if response.status != 201
        dispatch assign_success(id)
        response.data
      .then (data) ->
        dispatch add(normalize(data, schemas.alert))
      .catch (error) ->
        dispatch assign_failure(id, error.message)

close_request = (id) ->
  type: types.CLOSE_REQUEST
  id: id

close_success = (id) ->
  type: types.CLOSE_SUCCESS
  id: id

close_failure = (id, message) ->
  type: types.CLOSE_FAILURE
  id: id
  message: message

can_close = (id, getState) ->
    state = getState().control.alerts.close[id]
    state? and state.status != "requesting"

export close = (id) ->
  (dispatch, getState, axios) ->
    return unless can_close(id, getState)

    dispatch close_request(id)

    axios.patch "/alerts/#{id}/close"
      .then (response) ->
        throw Error("Can't close alert") if response.status != 200
        dispatch close_success(id)
        response.data
      .then (data) ->
        dispatch add(normalize(data, schemas.alert))
      .catch (error) ->
        dispatch close_failure(id, error.message)

export fetching = (page = "1") ->
  (dispatch, getState, axios) ->
    return if getState().control.alerts.fetching.status == "fetching"
    return unless page

    dispatch(fetchRequest())

    axios.get "/alerts?state=opened&page=#{page}"
      .then (response) ->
        throw Error("Can't fetch alerts") if response.status != 200
        dispatch(fetchSuccess(response.headers))
        response.data
      .then (data) ->
        dispatch(add(normalize(data, [ schemas.alert ])))
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
