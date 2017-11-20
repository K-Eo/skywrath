export selector = (state) ->
  items = []
  alerts = state.entities.alerts

  for key, value of alerts
    items.push value

  items
