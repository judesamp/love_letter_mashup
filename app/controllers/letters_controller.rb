class LettersController < ApplicationController

  def index
    @letters = current_user.letters.all
  end

end