debug = require("debug")("skywrath:push_middleware")

import _ from "lodash"
import { normalize } from "normalizr"
import alerts from "../alerts"

entity_exists = ({ getState }, type, entity) ->
  getState().entities[type][entity]?

push_middleware = ->
  (store) -> (next) -> (action) ->
    unless action.meta?
      return next(action)

    { data, meta, type } = action

    next_action = {
      type: type
      data: normalize(data, alerts.schemas.alert)
    }

    unless meta.action? and meta.type? and meta.entity?
      return next(next_action)

    debug "action with meta found %O", action

    switch meta.action
      when "load"
        debug "proccessing load"
        if entity_exists(store, meta.type, meta.entity)
          debug "entity %o:%o exists - skipping",
            meta.type,
            meta.entity
        else
          debug "entity %o:%o does not exist - loading",
            meta.type,
            meta.entity
          # TODO: Add thunk action to load user

    return next(next_action)


export default push_middleware
