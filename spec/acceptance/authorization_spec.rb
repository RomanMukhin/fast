require 'acceptance/acceptance_helper'

feature "Devise authorization" do
  given(:user)    { FactoryGirl.create(:user) }
  given(:new_user){ FactoryGirl.build(:user)  }

  scenario "existing user can sign in" do
    sign_in user
    page.should have_content user.name
  end

  scenario "current user can sign out" do
    sign_in user
    click_link "Sign out"
    page.should have_content "Signed out successfully"
  end
  
  scenario "guest can sign up" do
    visit root_path
    click_link "Sign up"
    fill_in 'Name', with: new_user.name
    fill_in 'Email', with: new_user.email
    fill_in 'user_password', with: new_user.password
    fill_in 'Password confirmation', with: new_user.password
    click_button "Sign up"
    page.should have_content new_user.name
  end
end

