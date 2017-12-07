import _ from 'lodash'

export const entities = (state = {}, action) => {
  switch (action.type) {
    case 'ADD':
      let users = action.data.entities.users

      if (users === null && users === undefined) {
        return state
      }

      return _.assign({}, state, users)
    default:
      return state
  }
}
