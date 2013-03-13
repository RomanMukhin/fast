require 'acceptance/acceptance_helper'

feature "User" do
  background do
    @user1, @user2, @user3 = FactoryGirl.create_list(:user, 3, password: '11111111') 
    @task =  FactoryGirl.create(:task)
  end

  context "can" do
    scenario "create task" do
      sign_in @user1
      click_link 'Create a task'
      fill_in 'Title', with: @task.title
      fill_in 'Description', with: @task.description
      click_button 'Create Task'
      page.should have_content('Task was successfully created')
      page.should have_content(@task.title)
    end
    
    scenario "cancel task" do
      prepare_task(@user1, @user2, true)
      sign_in @user1
      page.should have_content "#{@user2.name} applied for"
      within ".my_offers" do
        click_link 'Cancel'
      end
      page.should_not have_content "#{@user2.name} applied for"
    end
    
    scenario "accept task" do
      prepare_task(@user3)
      sign_in @user1
      visit('/tasks')
      page.should have_content('All available tasks')
      click_link 'Do this task'
      page.should have_content('Cancel')
    end

    scenario "destroy task" do
      prepare_task(@user1, @user2)
      sign_in @user1
      page.should have_content(@task.title)
      within ".my_offers" do
        click_link 'Delete'
      end
      page.should_not have_content(@task.title)
    end

    scenario "show users' profiles" do
      prepare_task(@user2)
      sign_in @user1
      visit user_path(@user2)
      page.should have_content("#{@user2.name}'s tasks")
      page.should have_content(@user2.offers.first.title)
    end
  end

  context "cannot" do
    scenario "create invalid task" do
      sign_in @user1
      click_link 'Create a task'
      fill_in 'Title', with: ''
      fill_in 'Description', with: @task.description
      click_button 'Create Task'
      page.should have_content("Title can't be blank") 
    end
    
    scenario "cancel alien task" do
      prepare_task(@user3, @user2, true)
      
      sign_in @user1
      visit user_path(@user3)
      page.should_not have_content "Cancel"
    end
    
     scenario "finish task if it's not in progress" do
      prepare_task(@user3, @user2)
      sign_in @user1
      page.should_not have_content "Finish"
    end    
  end

  def prepare_task(consumer, *args)
    if args.empty? || args == [true]
      @task.update_attributes!(consumer_id: consumer.id, doer_id: nil)
    else
      @task.update_attributes!(consumer_id: consumer.id, doer_id: args[0].id)
    end
    @task.apply! if args.include?(true)
  end
end