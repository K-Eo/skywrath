import { schema } from 'normalizr'

const user = new schema.Entity('users')

export const alert = new schema.Entity('alerts', {
  author: user,
  assignee: user
})
