# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/\


$ ->
  data = { "widget": { "name": "MyString", "description": "MyText", "stock": "1", "lat": "1", "long": "1" } }
  geo_options = {
    enableHighAccuracy: true,
    maximumAge : 30000,
    timeout : 27000
   }

  init = () ->
    $('.ajax').on 'click', logic

  logic = () ->
    navigator.geolocation.getCurrentPosition(success, error, geo_options)

  refreshPage = () ->
    location.reload()

  next = () ->
    $.ajax({
      url: "/widgets.json",
      type: "POST",
      datatype: 'json',
      data: data
      }).success(ajaxSuccess)
      .fail(fail)

  success = (position) ->
    data.widget.stock = position.timestamp
    data.widget.lat   = position.coords.latitude
    data.widget.long  = position.coords.longitude
    next()

  error = () ->
    console.log "error"

  ajaxSuccess = () ->
    location.reload()

  fail = () ->
    console.log event.currentTarget.response

  init()

