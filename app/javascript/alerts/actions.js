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
        const normalizeData = normalize(data, [ schemas.alert ])

        dispatch({
          type: 'ADD',
          entities: normalizeData.entities
        })

        return dispatch(fetchSuccess())
      })
      .catch(error => {
        return dispatch(fetchFailure(error.message))
      })
  }
}

const assignRequest = (id) => ({
  type: types.ASSIGN_REQUEST,
  id: id
})

const assignSuccess = (id) => ({
  type: types.ASSIGN_SUCCESS,
  id: id
})

const assignFailure = (id, message) => ({
  type: types.ASSIGN_FAILURE,
  id: id,
  message: message
})

export const assign = (id) => {
  return (dispatch, getState, axios) => {
    if (getState().control.alerts.assign[id] === 'requesting') {
      return Promise.resolve()
    }

    dispatch(assignRequest(id))

    axios.post(`/alerts/${id}/assign`)
      .then(response => {
        if (response.status === 201) {
          return response.data
        }

        throw Error(response.statusText)
      })
      .then(data => {
        const normalizeData = normalize(data, schemas.alert)

        dispatch({
          type: 'ADD',
          entities: normalizeData.entities
        })

        return dispatch(assignSuccess(id))
      })
      .catch(error => {
        return dispatch(assignFailure(id, error.message))
      })
  }
}
