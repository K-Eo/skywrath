import { schema } from "normalizr"

import users from "../users"

export alert = new schema.Entity "alerts", {
  author: users.schemas.user
  assisted_by: users.schemas.user
  closed_by: users.schemas.user
}
