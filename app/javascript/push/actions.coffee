import _ from "lodash"
import Pusher from "pusher-js"
import Settings from "../settings.js"
import * as types from "./types"
import alerts from "../watchdog/alerts"

push = null

getOptions = ->
  {
    encrypted: true
    cluster: "us2"
  }

getKey = ->
  Settings["pusher-key"]

state_change = (state) ->
  type: types.STATUS
  data: state

export service = ->
  (dispatch, getState) ->
    return if push?

    push = new Pusher getKey(), getOptions()

    push.connection.bind "state_change", ({ current }) ->
      dispatch(state_change(current))

export connect_channel = (channel) ->
  (dispatch) ->
    push.subscribe(channel).bind_global (event, data) ->
      action = _.assign {}, { type: event }, data
      dispatch(action)
