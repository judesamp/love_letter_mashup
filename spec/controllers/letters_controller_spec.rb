require 'spec_helper'

describe LettersController do 

  let(:letter_order) { FactoryGirl.create(:letter_order) }
  let(:user) { User.find(letter_order.user_id) }
  let(:letter) { Letter.find(letter_order.letter_id) }
  let(:letter2) { FactoryGirl.create(:letter) }
  let(:letter3) { FactoryGirl.create(:letter) }

  describe 'GET #index' do

    it "should assign current users collection of letters" do
      local_user = User.find(letter_order.user_id)
      local_letter = Letter.find(letter_order.letter_id)
      login(local_user)
      get :index
      expect(assigns(:letters)).to include local_letter
    end

  end

  describe 'GET #show' do

    it "should assign an offset for retrieving letters" do
      login(user)
      FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, :format => "js"
      expect(assigns(:offset)).to eq 1
    end

    it "assigns a direction" do
      login(user)
      FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:direction)).to eq "next"
    end

    it "assigns the current_letter" do
      login(user)
      letter2 = FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:current_letter)).to eq letter2
    end

    it "assigns the next letter" do
      login(user)
      FactoryGirl.create(:letter)
      letter3 = FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:next_letter)).to eq letter3
    end

    context "the previous letter" do

      it "assigns previous letter to nil if offset equals 0" do
        login(user)
        FactoryGirl.create(:letter)
        FactoryGirl.create(:letter)
        xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 0, direction: "next", :format => "js"
        expect(assigns(:previous_letter)).to eq nil
      end

      it "assigns previous letter to offset of -1 if offset is greater than 0" do
        login(user)
        letter2 = FactoryGirl.create(:letter)
        FactoryGirl.create(:letter)
        xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 2, direction: "next", :format => "js"
        expect(assigns(:previous_letter)).to eq letter2
      end

    end

  end

  describe "POST #create" do

    it "creates a new letter" do
      login(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      expect{
        post :create, letter: FactoryGirl.attributes_for(:letter)
      }.to change(Letter, :count).by(1)
    end

     it "redirects to index" do
      login(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      post :create, letter: FactoryGirl.attributes_for(:letter)
      response.should redirect_to "where_i_came_from"
    end

  end

  describe 'GET #switch_workspace' do
    
    it "assigns a workspace name to @workspace" do
      login(user)
      xhr :get, :switch_workspace, workspace: "workspace_name", :format => "js"
      expect(assigns(:workspace)).to eq 'workspace_name'
    end

    context "workspace equals full_letter_workspace" do
   
      it "assigns an offset of 0 to @offset" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:offset)).to eq 0
      end

      it "assigns the first letter to @current_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:current_letter)).to eq letter
      end
      it "assigns @previous_letter to nil" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:previous_letter)).to eq nil
      end

      it "assigns @next_letter to the second letter" do
        second_letter = letter2
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:next_letter)).to eq second_letter
      end

    end

  end

end