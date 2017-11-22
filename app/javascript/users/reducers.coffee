import _ from "lodash"
import alerts from "../watchdog/alerts"

export entities = (state = {}, action) ->
  switch action.type
    when alerts.types.ADD_BULK
      _.assign {}, state, action.data.entities.users
    else
      state
