require 'spec_helper'

describe LetterOrdersController do 
  let(:user) { FactoryGirl.create(:user) }
  let(:letter_order) { FactoryGirl.create(:letter_order) }
  let(:user_w_order) { User.find(letter_order.user_id) }
  let(:letter) { Letter.find(letter_order.letter_id) }

  describe "GET #show" do

    it "should assign a specific letter_order to @letter_order" do
      current_user = User.find(letter_order.user_id)
      login(current_user)
      get :show, id: letter_order
      expect(assigns(:letter_order)).to eq letter_order
    end

    it "should assign a specific letter to @letter" do
      current_user = User.find(letter_order.user_id)
      login(current_user)
      get :show, id: letter_order
      response.should render_template(:show)
    end

  end

  describe "POST #create" do

    it "creates a new letter order" do
      login(user)
      expect{
          post :create, letter_order: FactoryGirl.attributes_for(:letter_order)
      }.to change(LetterOrder, :count).by(1)
    end

  end

  describe "GET #deliver_as_email" do

    it "assigns letter_order to @letter_order" do
      current_user = User.find(letter_order.user_id)
      login(current_user)
      get :deliver_as_email, id: letter_order
      expect(assigns(:letter_order)).to eq letter_order
    end
      
    it "redirect to root_path" do
      current_user = User.find(letter_order.user_id)
      login(current_user)
      get :deliver_as_email, id: letter_order
      response.should redirect_to root_path
    end

  end

end


