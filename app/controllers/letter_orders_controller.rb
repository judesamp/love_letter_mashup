class LetterOrdersController < ApplicationController

  def create
    @letter_order = LetterOrder.new(letter_order_params)
    if @letter_order.save    
      redirect_to letter_order_path(@letter_order)
    else
      gflash notice: "There was a problem saving your order. Please try again"
      redirect_to :back
    end
  end

  def show
    @letter_order = LetterOrder.find(params[:id])
    @letter = Letter.find(@letter_order.letter_id)
  end

  # move to model
  def deliver_as_email
    @letter_order = LetterOrder.find(params[:id])
    letter = Letter.find(@letter_order.letter_id)
    LetterMailer.love_letter(current_user, letter, @letter_order).deliver
    gflash notice: "Your letter has been sent!"
    redirect_to root_path
  end

  private

  def letter_order_params
    params.require(:letter_order).permit(:recipient_email, :recipient_name, :type, :signature, :letter_id, :user_id)
  end
end