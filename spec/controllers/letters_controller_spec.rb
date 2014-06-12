require 'spec_helper'

describe LettersController do 

  let(:letter) { FactoryGirl.create(:letter) }
  let(:letter2) { FactoryGirl.create(:letter) }
  let(:letter3) { FactoryGirl.create(:letter) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do

    it "should assign current users collection of letters" do
      login(letter.letterable)
      get :index
      expect(assigns(:letters)).to include letter
    end

  end

  describe 'GET #show' do

    it "should assign an offset for retrieving letters" do
      login(user)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, :format => "js"
      expect(assigns(:offset)).to eq 1
    end

    it "assigns a direction" do
      login(user)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:direction)).to eq "next"
    end

    it "assigns the current_letter" do
      login(letter.letterable)
      letter2 = FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      puts assigns(:current_letter)
      expect(assigns(:current_letter)).to eq letter2
    end

    it "assigns the next letter" do
      login(letter.letterable)
      FactoryGirl.create(:letter)
      letter3 = FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:next_letter)).to eq letter3
    end

    context "the previous letter" do

      it "assigns previous letter to nil if offset equals 0" do
        login(letter.letterable)
        FactoryGirl.create(:letter)
        FactoryGirl.create(:letter)
        xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 0, direction: "next", :format => "js"
        expect(assigns(:previous_letter)).to eq nil
      end

      it "assigns previous letter to offset of -1 if offset is greater than 0" do
        login(letter.letterable)
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
      login(letter.letterable)
      xhr :get, :switch_workspace, workspace: "workspace_name", :format => "js"
      expect(assigns(:workspace)).to eq 'workspace_name'
    end

    context "workspace equals full_letter_workspace" do

      it "assigns an offset of 0 to @offset"

      it "assigns the first letter to @current_letter"

      it "assigns @previous_letter to nil"

      it "assigns @next_letter to the second letter"

    end

  end

end

#   def switch_workspace
#     @workspace = params[:workspace]
#     if @workspace == "full_letter_workspace"
#       @offset = 0
#       @current_letter = Letter.find 1
#       @previous_letter = nil
#       @next_letter = Letter.limit(1).offset(1)
#     end
#   end