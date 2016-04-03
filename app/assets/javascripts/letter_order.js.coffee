$ ->

	$(document).on 'click', '.send_email_button', (e) ->
    e.preventDefault();
    $('.snail_mail_order_letter').slideUp 800, ->
    	$('.email_letter_order').slideToggle 800, "linear", ->
    		return


    .email_letter_order
  $(document).on 'click', '.snail_mail_button', (e) ->
    e.preventDefault();
    $('.email_letter_order').slideUp 800, ->
   		$('.snail_mail_order_letter').slideToggle 800, "linear", ->
    		return