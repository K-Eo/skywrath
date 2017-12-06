<template>
  <div class="ui segment alert" :id="alert_id">
    <div class="alert-state">
      <a
        :class="state_label_class"
        :href="url"
      >
        <i class="warning circle icon"></i>
        {{ state_label_text }}
      </a>
    </div>

    <div class="alert-by">
      <a :href="url" class="ui black-text">
        <strong>#{{alert.id}}</strong>
        por
        <img
          :src="alert.author.avatar"
          :title="alert.author.name"
          class="ui avatar image"
        />
        <strong>{{alert.author.name}}</strong>
      </a>
    </div>

    <div class="alert-date">
      <timeago :since="alert.created_at" :auto-update="60"></timeago>
    </div>

    <div class="alert-assignee">
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
        :title="alert.assignee.name"
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
        classNames "ui basic label", {
          green: @alert.state == "opened"
          red: @alert.state == "closed"
        }
      state_label_text: ->
        switch @alert.state
          when "opened"
            "Activo"
          when "closed"
            "Cerrado"
          else
            "Desconocido"
      can_assign: ->
        @alert.state == "opened" &&
        not @alert.assignee? &&
        not @requesting
      has_assignee: ->
        @alert.assignee? &&
        not @requesting
      url: ->
        "/dashboard/alerts/#{@alert.id}"
      alert_id: ->
        "alert_#{@alert.id}"
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
