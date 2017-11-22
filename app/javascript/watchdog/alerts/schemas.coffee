import { schema } from "normalizr"

import users from "../../users"

export alert = new schema.Entity "alerts", {
  author: users.schemas.user
}
