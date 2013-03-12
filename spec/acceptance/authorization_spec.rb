require 'acceptance/acceptance_helper'

feature "Index Page when logged in" do
  background do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  scenario "VKMusic title" do
    visit "/"
    should_have content('My')
  end
end

