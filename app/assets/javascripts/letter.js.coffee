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
      $(".sortable").sortable update: (event, ui)->
        position = 1;
        neworder = new Array()
        $(this).children().each ->
          snippet_id = $(this).attr('data-snippet-id')
          letter_id = $(this).attr('data-letter-id')
          neworder.push(
            letter_id: letter_id
            snippet_id: snippet_id
            position: position
          )
          position += 1
          $.ajax
            url: letter_id + "/update_positions"
            type: "PATCH"
            data: { Activity: JSON.stringify(neworder) }
      #disableSelection()


        
  $(document).on 'click', '.answer', (e) ->
    #e.preventDefault();
    checkbox = $(this).children('input[type=checkbox]')
    snippet_id = $(checkbox).attr('data-snippet-id');
    checked = $(checkbox).prop('checked');
    letter = $('.snippet_view_workspace').attr('id');
    initial_value = $('.snippet_view_workspace').attr('data-letter-id');

    if letter == "false"
      $.ajax ({
        url: 'create_with_snippet',
        type: 'POST',
        data: { "letter": { "snippet_id": snippet_id, "letter_id": initial_value } }
      });

    else
      $.ajax ({
        url: letter + '/add_or_subtract_snippet',
        type: 'PATCH',
        data: { "snippet": { "snippet_id": snippet_id, "checked": checked } }
      });

    $(document).on 'click', '.send_snippet_letter_button', (e) ->
      e.preventDefault();
      letter_id = $('.snippet_view_workspace').attr('id');
      
      $.ajax ({
        url: letter_id + '/build_snippet_letter',
        type: 'PATCH',
      });

      $('.send_letter_modal').fadeIn();
      $('#fade').fadeIn();

  $(document).on 'click', '.answer', (e) ->


    
