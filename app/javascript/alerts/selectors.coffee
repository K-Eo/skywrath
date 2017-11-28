import { createSelector } from "reselect"
import _ from "lodash"

alerts_selector = (state) -> state.entities.alerts
users_selector = (state) -> state.entities.users
control_selector = (state) -> state.control.alerts.assignee

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
  control_selector,
  (alerts, users, controls) ->
    _.map alerts, (alert) ->
      author = { author: users[alert.author] }
      assignee = { assignee: users[alert.assignee] }
      assignee_control = { assignee_control: controls[alert.id] }
      _.assign {}, alert, author, assignee_control, assignee
)

export active_selector = createSelector(
  join_selector,
  (alerts) ->
    _.filter alerts, (i) -> i.state == "opened"
)


export chunck_selector = createSelector(
  join_selector,
  (alerts) -> _.take(alerts, 25)
)
