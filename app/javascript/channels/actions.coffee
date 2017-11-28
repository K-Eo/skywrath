import push from "../push"
import * as types from "./types"

add = (data) ->
  type: types.ADD
  data: data

remove = (name) ->
  type: types.REMOVE
  data: name

fetch_request = ->
  type: types.FETCH_REQUEST

fetch_success = ->
  type: types.FETCH_SUCCESS

fetch_failure = (message) ->
  type: types.FETCH_FAILURE
  message: message

export fetch_channels = ->
  (dispatch, getState, axios) ->
    return if getState().control.channels.fetching.status == "requesting"

    dispatch(fetch_request())

    axios.get("/channels")
      .then (response) ->
        throw Error(response.status) if response.status != 200
        dispatch(fetch_success())
        return response.data
      .then (data) ->
        dispatch(add(channel)) for channel in data
        dispatch(connect())
      .catch (error) ->
        dispatch(fetch_failure(error.message))

export connect = ->
  (dispatch, getState) ->
    for channel of getState().control.channels.items
      dispatch(push.actions.connect_channel(channel))
