require 'spec_helper'

describe User do
  let(:user_with_no_email) { User.new(email: "" ) }
  let(:user_with_invalid_email) { User.new(email: "isnotanemail" ) }
  let(:user_with_no_password) { User.new(password: "" ) }
  let(:user_with_no_password_confirmation) { User.new(password_confirmation: "" ) }

  it "should require an email" do
    user_with_no_email.should_not be_valid
  end

  it "should require a valid email" do
    user_with_invalid_email.should_not be_valid
  end

  it "should require a password" do
    user_with_no_password.should_not be_valid
  end


  it "should require a password confirmation" do
    user_with_no_password_confirmation.should_not be_valid
  end

end
