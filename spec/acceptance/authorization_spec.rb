require 'acceptance/acceptance_helper'

feature "Devise authorization" do
  given(:user) {FactoryGirl.create(:user, password: "11111111")}
  given(:new_user){ FactoryGirl.build(:user) }

  scenario "Signing in" do
    sign_in user
    page.should have_content user.name
  end

  scenario "Signing out" do
    sign_in user
    click_link "Sign out"
    page.should have_content "Signed out successfully"
  end
  
  scenario "Sign up" do
    visit root_path
    click_link "Sign up"
    fill_in 'Name', with: new_user.name
    fill_in 'Email', with: new_user.email
    fill_in 'user_password', with: "12345678"
    fill_in 'Password confirmation', with: "12345678"
    click_button "Create User"
    page.should have_content new_user.name
  end
end

