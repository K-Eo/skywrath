import _ from 'lodash'

export const entities = (state = {}, action) => {
  switch (action.type) {
    case 'ADD':
      if (action.entities && action.entities.users) {
        return _.assign({}, state, action.entities.users)
      }

      return state
    default:
      return state
  }
}
