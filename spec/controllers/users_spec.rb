require 'spec_helper'

describe  UsersController do
  context "destroy" do
  	before(:each) do
  	  @admin = FactoryGirl.create(:user, admin: true)
      @user = FactoryGirl.create(:user)
    end

    it "deletes users if has admin rights" do  
      sign_in @admin 
      delete :destroy, id: @user.id
      User.find_by_id(@user).should be_nil
    end

    it "doesnt delete with no admin rights" do
      sign_in @user
      delete :destroy, id: @admin.id
      User.find_by_id(@admin).should_not be_nil
    end
  end

  context "show" do	
    before(:each) do
      user = FactoryGirl.create(:user)
      sign_in user
      get :show, :id => user.id
    end
    
    it { subject.current_user.should_not be_nil}
    it { should assign_to(:user) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }	
  end
  context "index" do
    before(:each) do
	  @users = FactoryGirl.create_list(:user, 4)
	  sign_in @users.first
	  get :index
    end

    it { should respond_with(:success)  }
    it { should render_template(:index) }
    it { should assign_to(:users)}
  end
end