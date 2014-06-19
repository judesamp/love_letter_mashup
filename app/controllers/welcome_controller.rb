class WelcomeController < ApplicationController
  skip_filter :authenticate_user
  def index
    session[:user_id] = nil
  end
end
