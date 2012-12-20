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

        # new post
        $(document).on 'click' , '.newPostBtn', (event) ->
                event.preventDefault()
                # get the pageId from this buttons id
                pageId = $(this).attr('id').substring(10)
                # set hidden input inside news partial
                # (this is kind of messy... might be a better way)
                $('#newsModal').find('#page_id').val(pageId)

                

        # OB: is this still being used?
        #fields.toggle()
        #        $("#site_layout").change ->
        #        fields.toggle()

        #$("#site_name").keyup ->
        #        $('.site_name').text($(this).val())


        #fields = toggle: ->
        #  if $("#site_layout").val() is "custom"
        #    $("#custom_layout_fields").show()
        #  else
        #    $("#custom_layout_fields").hide()
        