class WelcomeController < ApplicationController
  skip_filter :authenticate_user
  layout 'welcome_header'
  
  def index
  end
end
