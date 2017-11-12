# Alerts API
Every API call to alerts must be authenticated.

## Alerts pagination
By default, `GET` requests 20 results at a time because the API results are paginated.

## List alerts
Get all alerts.

```sh
GET /alerts
```

Example response:

```json
[
  {
    "created_at": "2017-11-08T06:57:16.915Z",
    "author": {
      "id": 1,
      "name": "Mia Volkova",
      "avatar": "https://www.gravatar.com/avatar/653818ba2309289799cabc3e90033f83?s=80\u0026d=retro"
    }
  }
]
```

## Create new alert
```sh
POST /alerts
```

Example response:

```json
{
  "created_at": "2017-11-08T06:57:16.915Z"
}
```
