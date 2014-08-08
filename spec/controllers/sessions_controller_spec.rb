require 'spec_helper'

describe SessionsController do
	 let(:user) { FactoryGirl.create(:letter) }

  describe "POST #create" do

  	it "should set user_id to current user's id in session hash" do
			login(user)
			expect(session[:user_id]).to eq user.id
		end

  end

  describe "DELETE #destroy" do

  	it "should set user_id to nil" do
			logout(user)
			expect(session[:user_id]).to eq nil
		end

  end

end
