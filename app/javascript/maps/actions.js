import * as types from './types'

export const select = (id) => {
  return (dispatch) => {
    return dispatch({
      type: types.SELECT,
      id: id
    })
  }
}
