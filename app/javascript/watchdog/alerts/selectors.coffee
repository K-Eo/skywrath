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
  (alerts) -> _.orderBy(alerts, ["created_at", "id"], ["desc", "desc"]),
)

export chunck_selector = createSelector(
  order_selector,
  users_selector,
  (alerts, authors) ->
    items = _.take(alerts, 25)
    _.map items, (item) ->
      _.assign {}, item, { author: authors[item.author] }
)
