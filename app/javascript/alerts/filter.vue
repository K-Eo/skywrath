<template>
  <div class="ui floating labeled icon dropdown button">
    <i class="filter icon"></i>
    <span class="text">Filtrar</span>
    <div class="menu">
      <div class="header">
        <i class="warning circle icon"></i>
        Filtrar por estado
      </div>
      <div class="divider"></div>
      <div class="item" @click="filter('opened')">
        Activo
      </div>
      <div class="item" @click="filter('closed')">
        Cerrado
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
  import queryString from "query-string"

  export default
    data: -> {}
    methods:
      filter: (state) ->
        query = queryString.parse(location.search)
        query.state = state
        { origin, pathname } = location
        next_location = "#{origin}#{pathname}?#{queryString.stringify(query)}"
        Turbolinks.visit next_location
    mounted: ->
      { state } = queryString.parse(location.search)
      switch state
        when "opened"
          $(@$el).dropdown("set selected", "Activo")
        when "closed"
          $(@$el).dropdown("set selected", "Cerrado")
        else
          $(@$el).dropdown()
</script>
