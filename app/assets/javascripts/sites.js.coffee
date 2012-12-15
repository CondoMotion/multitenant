# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# simple email validation, not comprehensive, rely on server to check
# email actually exists by sending an email...
validateEmail = (email) ->
        re = /\S+@\S+\.\S+/
        re.test(email)

validateEmails = (input) ->
        emails = input.split(/,|;/)
        for email in emails
                if !validateEmail(email)
                        return false
        return true

$(document).ready ->
        $('#addManagerBtn').click ->
                $('#addManagerDialog').show()
                $(this).hide();
        $('#addManagerCancel').click ->
                $('#addManagerDialog').hide()
                $('#addManagerBtn').show()
                $('#emails').val('')
                $('#emailError').text('')
                        
        $('#addManagerSubmit').click ->
                if !validateEmails($('#emails').val())
                        $('#emailError').text('Invalid email format');
                        return false;

        # new site validation
        $('#newSiteBtn').click ->
                if $('#site_name').val().length == 0
                        $('#newSiteErr').text('name required')
                        return false
                if $('#site_subdomain').val().length == 0
                        $('#newSiteErr').text('subdomain required')
                        return false

        # site lise item click function
        $('.tab-link').click ->
                id = $(this).attr('id').substring(8)
                $('.tab-link').parent().removeClass('active')
                $(this).parent().addClass('active')
                $('.tab-pane').hide().removeClass('active')
                $('#tab-pane'+id).show().addClass('active')
                false
        # initially, just show the first tab
        $('.tab-pane').hide();
        $('.siteTabs').find('li').first().addClass('active');
        $('.siteTabs').find('.tab-pane').first().show().addClass('active');
        
        
# OB: what is this for?
$ ->
  fields.toggle()
  $("#site_layout").change ->
    fields.toggle()

  $("#site_name").keyup ->
  	$('.site_name').text($(this).val())


fields = toggle: ->
  if $("#site_layout").val() is "custom"
    $("#custom_layout_fields").show()
  else
    $("#custom_layout_fields").hide()