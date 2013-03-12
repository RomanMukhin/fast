require 'acceptance/acceptance_helper'

feature "Index Page when logged in" do
  background do
    @user = FactoryGirl.create(:user)
   
  end

  scenario "VKMusic title" do
    visit '/sessions/new'
    within("nav") do
      click_link 'Sign in'
      page.should have_content 'Success'
    end
  
  end
end

