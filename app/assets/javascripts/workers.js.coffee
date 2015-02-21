# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.Worker = {
  'placeWithParent': ( ->
    disableWithPlace = ->
      placeInput = $('[data-place-for-parent]')
      autocompleteValue = $('#worker_parent_id').val()

      if autocompleteValue != ''
        disabled = true
        placeInput.val(Worker.parentPlaces)
      else
        disabled = false

      placeInput.prop('disabled', disabled)


    bind = ->
      $(document).on 'autocomplete:update', disableWithPlace

    return {
      init: bind
    }
  )()
}
