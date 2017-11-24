import { createSelector } from "reselect"
import _ from "lodash"

alerts_selector = (state) -> state.entities.alerts
users_selector = (state) -> state.entities.users

array_selector = createSelector(
  alerts_selector,
  (alerts) -> _.values(alerts)
)

order_selector = createSelector(
  array_selector,
  (alerts) -> _.orderBy(alerts, ["created_at", "id"], ["desc", "desc"])
)

join_selector = createSelector(
  order_selector,
  users_selector,
  (alerts, users) ->
    _.map alerts, (alert) ->
      _.assign {}, alert, { author: users[alert.author] }
)

export active_selector = createSelector(
  join_selector,
  (alerts) -> _.filter(alerts, { state: "opened" })
)


export chunck_selector = createSelector(
  join_selector,
  (alerts) -> _.take(alerts, 25)
)
