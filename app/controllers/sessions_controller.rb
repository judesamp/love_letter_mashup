class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      gflash notice: "You are now logged in."
      redirect_to new_letter_path
    else
      gflash notice: "Something went wrong! We were unable to log you in."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    gflash :notice => "Signed out!"
    redirect_to login_path
  end

  def omniauth_create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    gflash :notice => "Signed in!"
    redirect_to new_letter_path
  end

  def omniauth_destroy
    session[:user_id] = nil
    gflash :notice => "Signed out!"
    redirect_to root_url
  end
  
end