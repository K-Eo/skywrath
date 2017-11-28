import _ from "lodash"

export entities = (state = {}, action) ->
  switch action.type
    when "ADD"
      users = action.data.entities.users
      return state unless users?
      _.assign {}, state, users
    else
      state
