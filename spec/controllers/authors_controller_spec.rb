require 'spec_helper'

describe AuthorsController do 

	it "should create an author" do
		current_user = FactoryGirl.create(:user)
		current_user.add_role :admin
  	login(current_user)
  	request.env["HTTP_REFERER"] = "where_i_came_from"
  	expect{
      post :create, author: FactoryGirl.attributes_for(:author)
    }.to change(Author, :count).by(1)
	end

	it "should create an author" do
		current_user = FactoryGirl.create(:user)
		current_user.add_role :admin
  	login(current_user)
  	request.env["HTTP_REFERER"] = "where_i_came_from"
    post :create, author: FactoryGirl.attributes_for(:author)
    response.should redirect_to "where_i_came_from"
	end

end