require "spec_helper"
require 'capybara/rspec'

def sign_in user
  visit root_path
  click_link 'Sign in'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end