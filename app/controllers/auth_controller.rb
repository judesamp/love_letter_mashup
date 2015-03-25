class AuthController < ApplicationController

  def facebook_callback
    facebook_token = request.env['omniauth.auth']['credentials']['token']
  end

  def twitter_callback
    twitter_token = request.env['omniauth.auth']['credentials']['token']
  end

end