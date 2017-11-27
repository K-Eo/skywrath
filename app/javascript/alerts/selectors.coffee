import { createSelector } from "reselect"
import _ from "lodash"

alerts_selector = (state) -> state.entities.alerts
users_selector = (state) -> state.entities.users
control_selector = (state) -> state.control.alerts.state_change

array_selector = createSelector(
  alerts_selector,
  (alerts) -> _.values(alerts)
)

order_selector = createSelector(
  array_selector,
  (alerts) -> _.orderBy(alerts, ["created_at", "id"], ["desc", "desc"])
)

make_events = (alert, users) ->
  { assisted_by, closed_by, assisting_at, closed_at } = alert
  events = []
  if assisted_by?
    user = users[assisted_by]
    if user?
      events.push {
        action: "asistió esta alerta"
        actor: user.name
        avatar: user.avatar
        date: assisting_at
      }
  if closed_by?
    user = users[closed_by]
    if user?
      events.push {
        action: "cerró esta alerta"
        actor: user.name
        avatar: user.avatar
        date: closed_at
      }
  events


join_selector = createSelector(
  order_selector,
  users_selector,
  control_selector,
  (alerts, users, controls) ->
    _.map alerts, (alert) ->
      author = { author: users[alert.author] }
      control = { control: controls[alert.id] }
      events = { events: make_events(alert, users) }

      _.assign {}, alert, author, control, events
)

export active_selector = createSelector(
  join_selector,
  (alerts) ->
    _.filter alerts, (i) ->
      i.state == "opened" or i.state == "assisting"
)


export chunck_selector = createSelector(
  join_selector,
  (alerts) -> _.take(alerts, 25)
)
