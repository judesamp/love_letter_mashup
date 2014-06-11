require 'spec_helper'


describe LettersController do 

  let(:letter) { FactoryGirl.create(:letter) }

  describe 'GET #index' do


  #redo after making letter polymorphic
  #   it "should assign current users collection of letters" do
  #     login(letter.user)
  #     get :index
  #     expect(assigns(:letters)).to include letter
  #   end

  # end

  # describe 'GET #switch_workspace' do
    
  #   it "assigns a workspace name to @workspace" do
  #     login(letter.user)
  #     xhr :get, :switch_workspace, workspace: "workspace_name", :format => "js"
  #     expect(assigns(:workspace)).to eq 'workspace_name'
  #   end

  end

end