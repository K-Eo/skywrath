<template>
  <button
    :class="button_classes"
    @click="create_alert"
    id="new_alert"
  >
    Nueva Alerta
  </button>
</template>

<script lang="coffee">
  import axios from "axios"
  import classNames from "classnames"

  export default
    data: ->
      requesting: false
    computed:
      button_classes: ->
        classNames "ui right floated green button", {
          loading: @requesting
        }
    methods:
      create_alert: ->
        return if @requesting

        @requesting = true

        axios.post "/api/v1/alerts"
          .then (response) =>
            throw Error(response.statusText) if response.status != 201
            response.data
          .then (data) =>
            @$emit("new-alert", data)
            @requesting = false
</script>
