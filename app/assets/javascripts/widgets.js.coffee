# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init = () ->
  data = { "name": "MyString", "description": "MyText", "stock": "1", "lat": "1", "long": "1" }
  header =
  $.ajax({
    beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')),
    url: "/widgets.json",
    type: "POST",
    datatype: 'json',
    data: data
    }).success(success)
    .fail(fail)

success = () ->
  alert "yeey"

fail = () ->
  console.log event.currentTarget.response

init()
