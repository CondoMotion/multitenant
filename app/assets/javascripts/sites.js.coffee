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

        # ------------------------------------------------
        # modal events:
        # TODO: move this to common.js
        closeModal = ($modal) ->
                $modal.hide()  # TODO: slide out?
                $('#blanket').hide()
        showModal = ($modal) ->
                $modal.show();
                $('#blanket').show()
        
        $('.close', '.cmoModal').click ->
                closeModal($(this).closest('.cmoModal'))
        $('.cancelBtn', '.cmoModal').click ->
                closeModal($(this).closest('.cmoModal'))
        #-------------------------------------------------

                
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
        $(document).on 'click', '.newNewsBtn', (event) ->
                event.preventDefault()
                pageId = $(this).attr('id').substring(10)
                # set hidden input inside of form partials
                $('#newsModal').find('#page_id').val(pageId)
                showModal( $('#newsModal') )

        $(document).on 'click', '.newDocBtn', (event) ->
                event.preventDefault()
                pageId = $(this).attr('id').substring(9)
                # set hidden input inside of form partials
                $('#documentsModal').find('#page_id').val(pageId)
                showModal( $('#documentsModal') )

        #
        # Editing site
        #

        # bootstrap tabs
        $('#settingsTab a').click (event) ->
                event.preventDefault()
                $(this).tab('show');

        # allow linking to specific tabs
        if location.hash != ''
                $('a[href="'+location.hash+'"]').tab('show')
        $('a[data-toggle="tab"]').on 'shown', (e) ->
                location.hash = $(e.target).attr('href').substr(1)
        # TODO: back button doesn't work with tabs, consider using history plugin.

        # add WYSIWYG editor to news
        if ($('#newsTextArea').length > 0)
                new nicEditor({buttonList:['bold','italic','underline','ol','ul',
                                           'removeformat','indent', 'outdent','upload',
                                           'link', 'unlink', 'fontisize']
                              }).panelInstance('newsTextArea')
        # TODO: need to sanitize text from NicEdit, could contain malicious scripts

