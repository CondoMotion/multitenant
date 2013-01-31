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

# Document Ready
$ ->
        # Tabs: TODO: probably easier to just make separate pages for managers and sites...
        $('#sitesLink').click ->
                $('#sitesLink').parent().addClass('active')
                $('#managersLink').parent().removeClass('active')
                $('#sitesTab').show()
                $('#managersTab').hide()
                return false
        $('#managersLink').click ->
                $('#managersLink').parent().addClass('active')
                $('#sitesLink').parent().removeClass('active')
                $('#managersTab').show()
                $('#sitesTab').hide()
                return false
                
        # add manager actions
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

        # site tabs
        $('.siteLink').click ->
                id = $(this).attr('id').substring(8)
                $('.siteLink').parent().removeClass('active')
                $(this).parent().addClass('active')
                $('.sitePanel').hide().removeClass('active')
                $('#sitePanel'+id).show().addClass('active')
                return false
        # initially, just show the first tab
        $('.sitePanel').hide();
        $('.siteList').find('li').first().addClass('active');
        $('.sitePanel').first().show();

        
        # editing managers
        $(document).on 'click', '.editMngrLink', (event) ->
                event.preventDefault()
                id = $(this).attr('id').substring(12)
                $('#editMngrs'+id).show();
                $('#viewMngrs'+id).hide();
        $(document).on 'click', '.editMngrCancel', (event) ->
                event.preventDefault()
                # TODO: restore state of checkboxes
                id = $(this).attr('id').substring(14)
                $('#editMngrs'+id).hide();
                $('#viewMngrs'+id).show();
        $(document).on 'click', '.editMngrSubmit', (event) ->
                $(this).addClass('disabled')
                $(this).parent().find('.spinner').show()

        # new posts
        $(document).on 'click', '.newPostBtn', (event) ->
                event.preventDefault()
                pageId = $(this).attr('id').substring(10)
                # set hidden input inside of form partials
                $('#newsModal, #documentsModal, #photosModal').find('#page_id').val(pageId)



        