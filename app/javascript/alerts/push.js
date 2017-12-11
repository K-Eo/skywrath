import { normalize } from 'normalizr'

import push from '../push'
import { alert } from './schemas'

export default (store) => {
  const alertsChannel = push.subscribe('alerts')

  const handleAdd = (data) => {
    const normalizeData = normalize(data, alert)

    store.dispatch({
      type: 'ADD',
      entities: normalizeData.entities
    })
  }

  alertsChannel.bind('new', handleAdd)
  alertsChannel.bind('assignee', handleAdd)
  alertsChannel.bind('close', handleAdd)
}
