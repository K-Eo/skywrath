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

state_change_request = (id) ->
  type: types.STATE_CHANGE_REQUEST
  id: id

state_change_success = (id) ->
  type: types.STATE_CHANGE_SUCCESS
  id: id

state_change_failure = (id, message) ->
  type: types.STATE_CHANGE_FAILURE
  id: id
  message: message

export assist = (id) ->
  (dispatch, getState, axios) ->
    state = getState().control.alerts.state_change[id]
    return unless state?
    return if state.status == "requesting"

    dispatch state_change_request(id)

    axios.post "/assists/#{id}/assist"
      .then (response) ->
        throw Error("Can't assist alert") if response.status != 201
        dispatch state_change_success(id)
        response.data
      .then (data) ->
        dispatch add(normalize(data, schemas.alert))
      .catch (error) ->
        dispatch state_change_failure(id, error.message)


export fetching = (page = "1") ->
  (dispatch, getState, axios) ->
    return if getState().control.alerts.fetching.status == "fetching"
    return unless page

    dispatch(fetchRequest())

    axios.get "/alerts?state=active&page=#{page}"
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
