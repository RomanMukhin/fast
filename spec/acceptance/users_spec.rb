require 'acceptance/acceptance_helper'

feature "Admin can manage users" do
  background do
    @users = FactoryGirl.create_list(:user,3) 
  	@admin = FactoryGirl.create(:admin, password: "11111111") 
  end
  
  scenario "Admin sees users" do
    sign_in @admin
    page.should have_content 'Listing users'
    3.times do |i|
      page.should have_content @users[i].name
    end
  end

  scenario "Admin can see users' accounts" do
  	sign_in @admin
  	within("#index_user_#{@users.first.id}") do
  	  click_link "Show"
    end
    page.should have_content('User info')
  	page.should have_content(@users[0].name)
  	page.should have_content(@users[0].city)
  end

  scenario "Admin can destroy users" do
  	sign_in @admin
  	within("#index_user_#{@users.first.id}") do
  	  click_link "Destroy"
    end
  	page.should have_content("User was successfully destroyed.")
  	page.should_not have_content(@users[0].name)
  end
end