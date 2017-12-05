<template>
  <div id="alerts-app" class="sixteen wide column">
    <div class="ui one column grid">

      <div class="row">
        <div class="column">
          <new-alert v-on:new-alert="new_alert"/>
          <filter-button />
        </div>
      </div>

      <div class="row" v-if="has_alerts">
        <div class="column">
          <div class="ui segments">
            <alert-item
              :alert="alert"
              :key="alert.id"
              @update-alert="new_alert"
              v-for="alert in alerts_selector"
            >
            </alert-item>
          </div>
        </div>
      </div>

      <div class="row" v-if="is_empty">
        <div class="column">
          <h3>No hay alertas</h3>
        </div>
      </div>

      <div class="row" v-if="fetching">
        <div class="column">
          <div class="ui active centered inline loader">
          </div>
        </div>
      </div>

      <div class="row" v-if="show_fetch_button">
        <div class="column center aligned">
          <button
            @click="fetch_alerts"
            class="ui default basic button"
            id="alerts_load_more"
          >
            Cargar más
          </button>
        </div>
      </div>

    </div>
  </div>
</template>

<script lang="coffee">
  import _ from "lodash"
  import axios from "axios"
  import queryString from "query-string"

  import push from "../push"
  import AlertItem from "./alert_item"
  import NewAlert from "./new_alert"
  import Filter from "./filter"


  export default
    components:
      "alert-item": AlertItem
      "new-alert": NewAlert
      "filter-button": Filter
    data: ->
      fetching: false
      alerts: { }
      next_page: 1
    computed:
      alerts_selector: ->
        items = _.values @alerts
        _.orderBy items, ["created_at", "id"], ["desc", "desc"]
      has_alerts: ->
        _.keys(@alerts).length > 0
      show_fetch_button: ->
        @next_page? && !@fetching
      is_empty: ->
        !@has_alerts && !@fetching
    methods:
      new_alert: (data) ->
        @alerts = _.assign {}, @alerts, { "#{data.id}": data }

      fetch_alerts: ->
        return unless @next_page?

        { state } = queryString.parse(location.search)

        state = "opened" unless state?

        @fetching = true
        axios.get "/api/v1/alerts?page=#{@next_page}&state=#{state}"
          .then (response) =>
            throw Error(response.statusText) if response.status != 200
            @next_page = response.headers["x-next-page"] || null
            response.data
          .then (data) =>
            items = {}

            for item in data
              items[item.id] = item

            @alerts = _.assign {}, @alerts, items
            @fetching = false
    created: ->
      channel = push.subscribe "alerts"
      channel.bind "new", @new_alert
      channel.bind "assignee", @new_alert
    destroyed: ->
      push.unsubscribe "alerts"
    mounted: ->
      @fetch_alerts()
</script>

<style> && !@fetching
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
