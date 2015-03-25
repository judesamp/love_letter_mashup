class LetterMailer < ActionMailer::Base
  default from: "lovelettermashup.com"

  def love_letter(user, letter, letter_order)
    @letter = letter
    @letter_order = letter_order
    @user = user
    #@url  = 'http://example.com/login'
    mail(to: @letter_order.recipient_email, subject: 'A Love Letter for You')
  end
end
