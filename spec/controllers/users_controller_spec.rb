require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }
  
  describe "GET #new" do

    it "assigns a new user with a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new page" do
      get :new
      response.should render_template :new
    end

  end

  describe "POST #create" do

    it "creates a new user" do
      user_attrs = FactoryGirl.attributes_for(:user)
      expect{
        post :create, user: user_attrs
      }.to change(User, :count).by(1)
    end

    it "sets the session[:user_id] to new user's id (if successfully created)" do
      user_attrs = FactoryGirl.attributes_for(:user)
      post :create, user: user_attrs
      expect(session[:user_id]).to eq User.last.id 
    
    end

    it "does not set the session[:user_id] to new user's id (if unsuccessful in create)" do
      user_attrs = FactoryGirl.attributes_for(:invalid_user)
      post :create, user: user_attrs
      expect(session[:user_id]).to eq nil 
  
    end

    it "renders the new letter page (if successfully created)" do
      user_attrs = FactoryGirl.attributes_for(:user)
      post :create, user: user_attrs
      response.should redirect_to new_letter_path
    end

    it "redirects to the welcome page (if create was unsuccessful)" do
      user_attrs = FactoryGirl.attributes_for(:invalid_user)
      post :create, user: user_attrs
      response.should redirect_to welcome_path
    end

  end

end