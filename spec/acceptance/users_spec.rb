require 'acceptance/acceptance_helper'

feature "Admin can manage users" do
  background do
    @user  = FactoryGirl.create(:user) 
  	@admin = FactoryGirl.create(:admin) 
  end
  
  scenario "Admin sees users" do
    sign_in @admin
    page.should have_content 'Listing users'
    page.should have_content @user.name
  end

  scenario "Admin can see users' accounts" do
  	sign_in @admin
  	within("#index_user_#{@user.id}") do
  	  click_link "Show"
    end
    page.should have_content('User info')
  	page.should have_content(@user.name)
  	page.should have_content(@user.city)
  end

  scenario "Admin can destroy users" do
  	sign_in @admin
  	within("#index_user_#{@user.id}") do
  	  click_link "Destroy"
    end
  	page.should have_content("User was successfully destroyed.")
  	page.should_not have_content(@user.name)
  end
end