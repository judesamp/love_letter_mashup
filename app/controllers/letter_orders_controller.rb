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
  end

  private

  def letter_order_params
    params.require(:letter_order).permit()
  end
end