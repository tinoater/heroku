# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/\

$ ->
  deleteArray = []
  ajaxBtn     = $('.ajax')
  compBtn     = $('.comp')
  deleteBtn   = $('.delete')
  list        = $('tbody')
  data        = { "widget": { "name": "MyString","description": "MyText", "stock": "1", "lat": "1", "long": "1" } }
  geo_options = {
    enableHighAccuracy: true,
    maximumAge : 30000,
    timeout : 27000
   }

  init = () ->
    ajaxBtn.on 'click', () -> logic(ajaxBtn)
    compBtn.on 'click', () -> test(compBtn)
    deleteBtn.on 'click', () -> deleteAll(deleteBtn)

  deleteAll = (element) ->
    queue = []
    loadingToggle(element)
    length = list.children().length
    for i in [0..(length - 1)]
      id = parseInt($(list.children()[i]).children()[0].innerHTML)
      queue.push(id)
    execQueue(queue)

  execQueue = (array) ->
    console.log array
    unless array.length == 0
      deleteAjax(array.shift(),array)
    ajaxSuccess(deleteBtn)
    return

  deleteAjax = (i,array) ->
    console.log "delete ajax"
    $.ajax({
      url: "/widgets/#{i}.json",
      type: "DELETE"
    }).success(execQueue(array))
    .fail(fail)

  test = (element) ->
    loadingToggle(element)
    getLatest()

  getLatest = () ->
    $.ajax({
      url: "/widgets.json",
      type: "GET",
      datatype: 'json',
    }).success(compSuccess)
    .fail(fail)

  compSuccess = (widgetData) ->
    loadingToggle(compBtn)
    lastUpdate = widgetData[widgetData.length - 1]
    lat  = lastUpdate.lat
    long = lastUpdate.long
    if Math.round(lat) + Math.round(long) == 45
      alert "You're a winner"
      return
    alert 'you loose'

  logic = (element) ->
    loadingToggle(element)
    navigator.geolocation.getCurrentPosition(success, error, geo_options)

  loadingToggle = (element) ->
    element.toggleClass('loading')

  next = () ->
    $.ajax({
      url: "/widgets.json",
      type: "POST",
      datatype: 'json',
      data: data
    }).success(ajaxSuccess(ajaxBtn))
    .fail(fail)

  success = (position) ->
    data.widget.stock = position.timestamp
    data.widget.lat   = position.coords.latitude
    data.widget.long  = position.coords.longitude
    next()

  error = (error) ->
    console.log error

  ajaxSuccess = (element) ->
    setTimeout(() ->
      loadingToggle(element)
      location.reload()
    , 500)  ## Stops race contitions (not ideal)

  fail = () ->
    console.log event.currentTarget.response

  init()

