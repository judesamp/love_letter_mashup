$ ->
  
  $(document).on 'click', '#fade', ->
    $("#fade").hide();
    $(".modal_custom").hide();

  $(document).on 'click', '.close', ->
    $("#fade").hide();
    $(".modal_custom").hide();

  $(document).on 'click', '.send_letter_button', (e) ->
    e.preventDefault();
    # letter_id = $('.letter_data').attr('data-letter-id');
    # user_id = $('.letter_data').attr('data-user-id');

    # $.ajax ({
    #   url: letter_id + '/add_to_user',
    #   type: 'POST',
    #   data: { "letter": { "user_id": user_id} }
    # });

    $('.send_letter_modal').fadeIn();
    $('#fade').fadeIn();

  $(document).on 'click', '#fade_instructions', ->
      $("#fade_instructions").hide();
      $(".modal_custom_instructions").hide();

  $(document).on 'click', '.close_instructions', ->
      $("#fade_instructions").hide();
      $(".modal_custom_instructions").hide();

  $(document).on 'click', ->
    $('.gritter-item').fadeOut('slow');

  $(document).on 'click', '.snippet_view', (e) ->
    e.preventDefault();
    $(".letter_view_workspace").hide "slide", { direction: "right" }, 600, -> 
      $(".snippet_view_workspace").show "slide", { direction: "left" }, 600

  $(document).on 'click', '.letter_view', (e) ->
    e.preventDefault();
    $(".snippet_view_workspace").hide "slide", { direction: "right" }, 600, ->
      $(".letter_view_workspace").show "slide", { direction: "left" }, 600
       
    

