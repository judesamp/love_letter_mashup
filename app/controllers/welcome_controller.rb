class WelcomeController < ApplicationController
  skip_filter :authenticate_user
  def index
    
  end
end
