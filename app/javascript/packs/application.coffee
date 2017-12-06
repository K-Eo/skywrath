debug = require("debug")("skywrath:application")
import "../flash"
import "../timing"

$(document).on "turbolinks:load", ->
  $(".ui.dropdown").dropdown()
  debug "UI dropdown"

$(document).on "turbolinks:load", ->
  return unless $(".alerts.show").length > 0

  uluru =
    lat: -25.363
    lng: 131.044

  map = new google.maps.Map(document.getElementById("live-map"), {
    zoom: 10,
    center: uluru
    });
  marker = new google.maps.Marker({
    position: uluru,
    map: map
    });
