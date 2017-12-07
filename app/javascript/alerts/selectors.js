import _ from 'lodash'
import { createSelector } from 'reselect'

const alertsSelector = (state) => state.entities.alerts
const usersSelector = (state) => state.entities.users
const controlSelector = (state) => state.control.alerts.fetching

const arraySelector = createSelector(
  alertsSelector,
  (alerts) => _.values(alerts)
)

const orderSelector = createSelector(
  arraySelector,
  (alerts) => _.orderBy(alerts, ['created_at', 'id'], ['desc', 'desc'])
)

const joinSelector = createSelector(
  orderSelector,
  usersSelector,
  controlSelector,
  (alerts, users, control) => {
    return _.map(alerts, (alert) => {
      const author = { author: users[alert.author] || null }
      const assignee = { assignee: users[alert.assignee] || null }
      const fetching = { fetching: control }
      return _.assign({}, alert, author, assignee, fetching)
    })
  }
)

export const defaultSelector = createSelector(
  joinSelector,
  (alerts) => _.filter(alerts, (i) => i.state === 'opened')
)
