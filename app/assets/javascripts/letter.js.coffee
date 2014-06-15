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
    letter_id = $('.snippet_view_workspace').attr('id');
    
    unless letter_id == "false"
      $.ajax ({
        url: letter_id + '/retrieve_letter',
        type: 'GET'
      });
    $(".snippet_view_workspace").hide "slide", { direction: "right" }, 600, ->
      $(".letter_view_workspace").show "slide", { direction: "left" }, 600
       
    
  $(document).on 'click', ':checkbox', (e) ->
    #e.preventDefault();
    snippet_id = $(this).attr('data-snippet-id');
    checked = $(this).prop('checked');
    letter = $('.snippet_view_workspace').attr('id');

    if letter == "false"
      $.ajax ({
        url: 'create_with_snippet',
        type: 'POST',
        data: { "letter": { "snippet_id": snippet_id, "checked": checked } }
      });

    else 
      $.ajax ({
        url: letter + '/add_or_subtract_snippet',
        type: 'PATCH',
        data: { "snippet": { "snippet_id": snippet_id, "checked": checked } }
      });


    