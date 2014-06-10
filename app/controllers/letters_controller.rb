class LettersController < ApplicationController

  def index
    @letters = current_user.letters.all
  end

  def switch_workspace
    puts params[:workspace]
    @workspace = params[:workspace]
  end

end