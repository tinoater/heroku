# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/\

$ ->
  deleteArray = []
  ajaxBtn     = $('.ajax')
  compBtn     = $('.comp')
  deleteBtn   = $('.delete')
  list        = $('tbody')
  data        = { "widget": { "name": "MyString", "description": "MyText", "stock": "1", "lat": "1", "long": "1" } }
  geo_options = {
    enableHighAccuracy: true,
    maximumAge : 30000,
    timeout : 27000
   }

  init = () ->
    ajaxBtn.on    'click', getLocation
    compBtn.on    'click', () -> test(compBtn)
    deleteBtn.on  'click', () -> deleteAll(deleteBtn)

  ajax = (url,type,data=0,success) ->
    ajaxObject = {
      url: url,
      type: type,
      datatype: 'json'
    }
    if data != 0
      ajaxObject['data'] = data
    $.ajax(ajaxObject)
      .success(success)
      .fail(fail)

  getLocation = () ->
    loadingToggle(ajaxBtn)
    navigator.geolocation.getCurrentPosition(getSuccess, error, geo_options)

  loadingToggle = (element) ->
    element.toggleClass('loading')

  getSuccess = (position) ->
    data.widget.stock = position.timestamp
    data.widget.lat   = position.coords.latitude
    data.widget.long  = position.coords.longitude
    ajax("/widgets.json","POST",data,appGetSuccess(ajaxBtn))

  appGetSuccess = (element) ->
    setTimeout(() ->
      loadingToggle(element)
      location.reload()
    , 500)  ## Stops race contitions (not ideal)

  deleteAll = (element) ->
    loadingToggle(element)
    queue  = []
    length = list.children().length
    for i in [0..(length - 1)]
      id = parseInt($(list.children()[i]).children()[0].innerHTML)
      queue.push(id)
    execQueue(queue)

  execQueue = (array) ->
    unless array.length == 0
      ajax("/widgets/#{array.shift()}.json","DELETE",execQueue(array))
    appGetSuccess(deleteBtn)
    return

  test = (element) ->
    loadingToggle(element)
    ajax("/widgets/json","GET",compSuccess)

  compSuccess = (widgetData) ->
    lastUpdate = widgetData[widgetData.length - 1]
    lat        = lastUpdate.lat
    long       = lastUpdate.long
    loadingToggle(compBtn)
    if Math.round(lat) + Math.round(long) == 45
      alert "You're a winner"
      return
    alert 'you loose'

  fail = () ->
    console.log event.currentTarget.response

  error = (error) ->
    console.log error

  init()

