import { normalize } from 'normalizr'

import * as types from './types'
import * as schemas from './schemas'

const fetchRequest = () => ({
  type: types.FETCH_REQUEST
})

const fetchSuccess = () => ({
  type: types.FETCH_SUCCESS
})

const fetchFailure = (message) => ({
  type: types.FETCH_FAILURE,
  message: message
})

const canFetch = (getState) => {
  const status = getState().control.alerts.fetching.status
  return status !== 'fetching'
}

export const fetch = () => {
  return (dispatch, getState, axios) => {
    if (!canFetch(getState)) {
      return Promise.resolve()
    }

    dispatch(fetchRequest())

    axios.get('/alerts?state=opened')
      .then(response => {
        if (response.status === 200) {
          return response.data
        }

        throw Error(response.statusText)
      })
      .then(data => {
        dispatch({
          type: 'ADD',
          data: normalize(data, [ schemas.alert ])
        })
        return dispatch(fetchSuccess())
      })
      .catch(error => {
        return dispatch(fetchFailure(error.message))
      })
  }
}
