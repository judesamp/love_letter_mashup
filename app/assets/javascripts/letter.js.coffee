$ ->
  
  $(document).on 'click', '#fade', ->
    $("#fade").hide();
    $(".modal_custom").hide();

  $(document).on 'click', '.close', ->
    $("#fade").hide();
    $(".modal_custom").hide();

  $(document).on 'click', '.send_letter_button', (e) ->
    e.preventDefault();
    letter_id = $('.letter_data').attr('data-letter-id');
    user_id = $('.letter_data').attr('data-user-id');

    $.ajax ({
      url: letter_id + '/add_to_user',
      type: 'POST',
      data: { "letter": { "user_id": user_id} }
    });

    $('.send_letter_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '.letter_order_button', (e) ->
    alert('here')

