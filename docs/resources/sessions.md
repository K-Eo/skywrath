# Session API
API to authenticate on Skywrath.

## Login
Retrieves access token as JSON response.

```sh
POST /sessions
```

Example response:

```JSON
{
  "access_token": "AheJpvBs5tK9koXpg98e"
}
```

Attribute | Type | Required | Description
--- | --- | --- | ---
email | string | yes | User email.
password | string | yes | User password.

## Logout
Logout from Skywrath.

```sh
DELETE /sessions/:access_token
```

Attribute | Type | Required | Description
--- | --- | --- | ---
`access_token` | string | yes | The access token generate when logged in.
