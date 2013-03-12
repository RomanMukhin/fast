require 'spec_helper'

describe Devise::SessionsController do
  context "sign in" do
  	before(:each) do
  	  @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user, email: "r@u.rr", password: "11111111")
      post :create, user:{email: "r@u.rr", password: "11111111"}
    end
    
    it { subject.current_user.should_not be_nil}
    it { should respond_with(302) }
    it { should redirect_to root_path }
    it { should set_the_flash }
  end

  context "sign in" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user, email: "r@u.rr", password: "11111111")
      sign_in @user
      delete :destroy
    end
    
    it { subject.current_user.should be_nil}
    it { should respond_with(302) }
    it { should redirect_to root_path }
    it { should set_the_flash }
  end
end