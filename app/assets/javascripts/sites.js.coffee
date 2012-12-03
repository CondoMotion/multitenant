# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  fields.toggle()
  $("#site_layout").change ->
    fields.toggle()


fields = toggle: ->
  if $("#site_layout").val() is "custom"
    $("#custom_layout_fields").show()
  else
    $("#custom_layout_fields").hide()