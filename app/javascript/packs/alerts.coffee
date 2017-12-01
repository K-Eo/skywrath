import Vue from "vue/dist/vue.esm"
import VueTimeago from "vue-timeago"

import App from "../alerts/app.vue"
import push from "../push"

Vue.use VueTimeago, {
  name: "timeago"
  locale: "es-ES",
  locales: {
    "es-ES": require("vue-timeago/locales/es-ES.json")
  }
}

destroyVue = ->
  @$destroy()
  document.removeEventListener("turbolinks:before-cache", destroyVue)

document.addEventListener "turbolinks:load", ->
  return unless $(".alerts.index").length > 0

  app = new Vue {
    el: "#content-body"
    template: "<App/>"
    components:
      App: App
    beforeMount: ->
      @$originalElement = @$el.outerHTML
      document.addEventListener("turbolinks:before-cache", destroyVue.bind(this))
    destroyed: ->
      @$el.outerHTML = @$originalElement
  }
