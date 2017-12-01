<template>
  <div class="ui segment alert">
    <div class="state">
      <span :class="state_label_class">
        <i class="warning icon"></i>
      </span>
    </div>

    <div class="content">
      <strong>{{alert.author.name}}</strong>
      <span>envío esta alerta</span>
      <p class="meta">
        #{{alert.id}} &bull;
        <timeago :since="alert.created_at" :auto-update="30"></timeago>
      </p>
    </div>

    <div class="assignee">
      <a
        @click.prevent="assign"
        href="#"
        v-if="can_assign"
      >
        asignarme
      </a>

      <div
        class="ui small active centered inline loader"
        v-if="requesting"
      >
      </div>

      <img
        :src="alert.assignee.avatar"
        class="ui avatar image"
        v-if="has_assignee"
      />
    </div>
  </div>
</template>

<script lang="coffee">
  import axios from "axios"
  import classNames from "classnames"

  export default
    props:
      alert:
        type: Object
        required: true
    data: ->
      requesting: false
    computed:
      state_label_class: ->
        classNames "ui tiny circular label", {
          green: @alert.state == "opened"
          red: @alert.state == "closed"
        }
      can_assign: ->
        @alert.state == "opened" &&
        not @alert.assignee? &&
        not @requesting
      has_assignee: ->
        @alert.assignee? &&
        not @requesting
    methods:
      assign: ->
        @requesting = true
        axios.post "/api/v1/alerts/#{@alert.id}/assign"
          .then (response) =>
            throw new Error(response.statusText) if response.status != 201
            response.data
          .then (data) =>
            @$emit("update-alert", data)
            @requesting = false

</script>

<style>
</style>
