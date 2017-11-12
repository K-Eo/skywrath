# Skywrath API
Skywrath via simple and powerful API.

## Resources
Documentation for various API resources can be found separately in the following locations:

* [Alerts](/docs/resources/alerts.md)

## Basic usage
API requests should be prefixed with `api` and the API versión. For example, the root of the v1 API is at `/api/v1`.

Example of a valid API request using cURL:
```sh
curl "https://skywrath.herokuapp.com/api/v1/alerts
```
The API uses JSON to serialize data. You don't need to specify `.json` at the end of an API URL.

## Authentication
Most API requests require authentication, or will only return public data when authentication is nor provided. For those cases where it is not required, this will be mentioned in the documentation for each individual endpoint.

There are two ways to authenticate with the Skywrath API:

1. [Personal access token](#personal-access-token)
2. [Session cookie](#session-cookie)

If authentication information is invalid or omitted, an error message will be returned with status code 401:
```json
{
  "message": "401 Unauthorized"
}
```

## Personal access token
You ca user a personal access token to authenticate with the API by passing it in either `access_token` parameter or `X-Access-Token` header.

Example of using the personal access token in a parameter:
```sh
curl "https://skywrath.herokuapp.com/api/v1/alerts?access_token=AheJpvBs5tK9koXpg98e
```
Example using the personal access token in a header:
```sh
curl --header "X-Access-Token: AheJpvBs5tK9koXpg98e" https://skywrath.herokuapp.com/api/v1/alerts
```

## Session cookie
when signed in to the main Skywrath application, a `_skywrath_session` cookie is set. The API will use this cookie for authentication if it is present, but using the API to generate a new session cookie is currently not supported.


## Status codes
The API is designed to return different status codes according to context and action. This way, if a request results in an error, the caller is able to ge insight into what went wrong.

The following table gives an overview of how the API functions generally behave.

Request type|Description
---|---
`GET` | Access one or more resources and return the result as JSON.
`POST` | Return `201 Created` if the resource is successfully created and return the newly created resource as JSON.
`GET/PUT` | return `200 OK` if the resource is accessed or modified successfully. The (modified) result is returned as JSON.
`DELETE` | Returns `204 No Content` if the resource was deleted successfully.

The following table shows the possible return codes for API requests.

Return values | Description
--- | ---
`200 OK` | The `GET`, `PUT`, or `DELETE` request was successful, the resource(s) itself is returned as JSON.
`204 No Content` | The server has successfully fulfilled the request and that there is no additional content to send in the response payload body.
`201 Created` | The `POST` request was successful and the resource is returned as JSON.
`400 Bad Request` | A required attribute of the API request is missing.
`201 Unauthorized` | The user is not authenticated, a valid acces token is necessary.
`203 Forbidden` | Te quest is not allowd, e.g., the user is not allowed to delete a project.
`404 Not Found` | A resource could not be accesse.
`405 Method Not Allowed` | The request is not supported.
`500 Server Error` | While handling the request something went wrong server-side.

## Pagination
Sometimes the returned result will span across many pages. When listing resources you can pass the following.

Parameter | Description
--- | ---
`page` | Page number (default: `1`)
`per_page` | Number of items to list per page (default: `20`, max: `50`)

In the example below, we list 50 alerts per page.

```sh
curl --header "X-Access-Token: AheJpvBs5tK9koXpg98e" https://skywrath.herokuapp.com/api/v1/alerts?per_page=50
```

## Pagination Link Header
Link headers are sent back with each response. Theay have rel set to pre/next/first/last and contain the relevant URL. Please use these links instead of generating your own URLs.

In the cURL example below, we use default params:

```sh
curl --head --header "X-Access-Token: AheJpvBs5tK9koXpg98e" skywrath.herokuapp.com/api/v1/alerts
```
The response will then be:

```sh
HTTP/1.1 200 OK
X-Total: 36
X-Total-Pages: 2
X-Per-Page: 25
X-Page: 1
X-Next-Page: 2
X-Prev-Page: 
Link: <http://skywrath.herokuapp.com/api/v1/alerts?page=2&per_page=25>; rel="next", <http://skywrath.herokuapp.com/api/v1/alerts?page=1&per_page=25>; rel="first", <http://skywrath.herokuapp.com/api/v1/alerts?page=2&per_page=25>; rel="last"
Content-Type: application/json
Vary: Origin
Cache-Control: no-cache
X-Request-Id: 269dc51d-96c4-48b5-bb52-df7faf360ead
X-Runtime: 0.030114
Content-Length: 4601
```

## Other pagination headers
Additional pagination headers are also sent back.

Header | Description
--- | ---
`X-Total` | The total number of items
`X-Total-Pages` | The total number of pages
`X-Per-Page` | The number of items per page
`X-Page` | The index of the current page (starting at 1)
`X-Next-Page` | The index of the next page
`X-Prev-Page` | The index of the previous page
