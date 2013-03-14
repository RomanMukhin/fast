require 'acceptance/acceptance_helper'

feature "User" do
  given(:task)        { FactoryGirl.create(:task)         }
  given(:user)        { FactoryGirl.create(:user)         }
  given(:applied_task){ FactoryGirl.create(:applied_task)}
  given(:offer)       { FactoryGirl.create(:offer)        }

  context "can" do
    scenario "create task" do
      sign_in task.consumer
      click_link 'Create a task'
      fill_in 'Title', with: task.title
      fill_in 'Description', with: task.description
      click_button 'Create Task'
      page.should have_content('Task was successfully created')
      page.should have_content(task.title)
    end
    
    scenario "cancel task" do
      sign_in applied_task.consumer
      page.should have_content "#{applied_task.doer.name} applied for"
      within ".my_offers" do
        click_link 'Cancel'
      end
      page.should_not have_content "#{applied_task.doer.name} applied for"
    end
    
    scenario "accept task" do
      sign_in user
      visit(user_path(offer.id))
      click_link 'Find a task'
      page.should have_content('All available tasks')
      click_link 'Do this task'
      page.should have_content('Cancel')
    end

    scenario "destroy task" do
      sign_in task.consumer
      page.should have_content(task.title)
      within ".my_offers" do
        click_link 'Delete'
      end
      page.should_not have_content(task.title)
    end

    scenario "see users' profiles" do
      sign_in user
      visit user_path(offer.consumer)
      page.should have_content("#{offer.consumer.name}'s tasks")
      page.should have_content(offer.title)
    end
  end

  context "cannot" do
    scenario "create invalid task" do
      sign_in task.consumer
      click_link 'Create a task'
      fill_in 'Title', with: ''
      fill_in 'Description', with: task.description
      click_button 'Create Task'
      page.should have_content("Title can't be blank") 
    end
    
    scenario "cancel alien task" do
      sign_in task.consumer
      visit user_path(user)
      page.should_not have_content "Cancel"
    end
    
     scenario "finish task if it's not in progress" do
      sign_in user
      page.should_not have_content "Finish"
    end    
  end
end