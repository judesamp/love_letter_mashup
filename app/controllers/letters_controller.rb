class LettersController < ApplicationController

  def index
    @letters = current_user.letters.all
  end

  def show
    @offset = params[:offset].to_i
    @direction = params[:direction]
    puts params[:direction]
    @current_letter = Letter.limit(1).offset(@offset).first
    @next_letter = Letter.limit(1).offset(@offset + 1).first
    if @offset == 0
      @previous_letter = nil
    else
      @previous_letter = Letter.limit(1).offset(@offset - 1).first
    end
  end

  def create
    @letter = Letter.new(letter_params)
    if @letter.save
      gflash notice: "Your letter has been created successfully!"
      redirect_to :back
    else
      gflash notice: "Something went wrong tryign to save your letter. Please try again."
      redirect_to :back
    end
  end

  def switch_workspace
    @workspace = params[:workspace]
    case @workspace
    when "full_letter_workspace"
      @offset = 0
      @current_letter = Letter.find 1
      @previous_letter = nil
      @next_letter = Letter.limit(1).offset(1)
    end
  end

  private

  def letter_params 
    params.require(:letter).permit(:content, :letterable_id, :letterable_type)
  end

end