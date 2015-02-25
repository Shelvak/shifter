# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.Worker = {
  'placeWithParent': ( ->
    disableWithPlace = ->
      $('[data-place-for-parent]').html(Worker.parentPlaces || '')

    bind = ->
      $(document).on 'autocomplete:update', disableWithPlace

    return {
      init: bind
    }
  )()
}
