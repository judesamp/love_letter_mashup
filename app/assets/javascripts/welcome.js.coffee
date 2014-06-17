# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  $(document).on 'click', '.signup_button', (e) ->
    e.preventDefault();
    $('.signup_modal').appendTo("body").fadeIn('slow');
    $('#fade').fadeIn();

