require 'spec_helper'

describe Devise::RegistrationsController do
  before(:each) do
  	@request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
  end

  context "sign_up" do
  	before(:each) do
      get :new
    end
    
    it { should assign_to(:user) }
    it { should respond_with(:success) }
    it { should render_template('registrations/new') }
    it { should_not set_the_flash }
  end

  context "edit user registration" do
    before(:each) do 
      sign_in @user
      get :edit, id: @user.id
    end
    
    it { should assign_to(:user) }
    it { should respond_with(:success) }
    it { should render_template('registrations/edit') }
    it { should_not set_the_flash }
  end
end