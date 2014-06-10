class UsersController < ApplicationController
  skip_filter :authenticate_user, :only => [:create, :new]

  def dashboard

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to letters_path, notice: "You've signed up and we've logged you in. Now go mash some letters."
    else
      redirect_to letters_path, notice: "We were unable to create your account. Please try again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_confirmation, :password)
  end

end