require 'spec_helper'

describe SnippetsController do
	let(:user) { FactoryGirl.create(:user) }

  describe "POST #create" do

  	it "should create a new snippet and assign it to @snippet" do
  		user.add_role :admin
  		login(user)
  		request.env["HTTP_REFERER"] = "where_i_came_from"
    	expect{
    		post :create, snippet: FactoryGirl.attributes_for(:snippet)
    	}.to change(Snippet, :count).by(1)
  	end

  	it "should redirect back where request originated" do
  		user.add_role :admin
  		login(user)
  		request.env["HTTP_REFERER"] = "where_i_came_from"
  		post :create, snippet: FactoryGirl.attributes_for(:snippet)
  		response.should redirect_to "where_i_came_from"
  	end	

  end

end