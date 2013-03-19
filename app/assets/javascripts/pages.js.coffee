# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
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

        $('#addPostBtn').click ->
                showModal( $('#newsModal') )


        
	$('#pages').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

  $('.best_in_place').best_in_place()

  $(document).tooltip selector: "[rel~=tooltip]"

        