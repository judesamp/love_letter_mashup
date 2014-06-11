class LettersController < ApplicationController

  def index
    @letters = current_user.letters.all
  end

  def show
    # letter_offset = params[:offset]
    # @current_letter = Letter.limit(1).offset(letter_offset)
    # @previous_letter = Letter.limit(1).offset(letter_offset - 1)
    # @next_letter = Letter.limit(1).offset(letter_offset + 1)
    # puts @current_letter
    # puts @previous_letter
    # puts @next_letter
  end

  def switch_workspace
    @workspace = params[:workspace]
  end

end