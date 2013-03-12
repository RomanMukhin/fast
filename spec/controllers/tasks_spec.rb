require 'spec_helper'

describe  TasksController do
  before(:each) do
    @users = FactoryGirl.create_list(:user,2)
    sign_in @users.first
    @tasks = FactoryGirl.create_list(:task, 3, consumer_id: @users.first.id)
  end

  context "index" do
  	before(:each){ get :index }
    it { subject.current_user.should_not be_nil}
<<<<<<< HEAD
    it { should assign_to(:tasks) }
=======
    it { should assign_to(:users) }
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should_not set_the_flash } 
  end

  context "show" do	
    before(:each) {get :show, :id => @users.first.id}
    
    it { subject.current_user.should_not be_nil}
    it { should assign_to(:task) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }	
  end

  context "edit" do
    context "authorized user" do
      before(:each) do
  	    get :edit, id: @tasks.first.id
      end

      it { should respond_with(:success)  }
      it { should render_template(:edit) }
      it { should assign_to(:task)}
    end

    context "unauthorized user" do
      before(:each) do
        sign_out @users.first
        sign_in @users.last
        get :edit, id: @tasks.first.id
      end

      it { should_not respond_with(:success)  }
      it { should redirect_to root_path }
    end
  end

  context "update" do
    context "authorized user" do
      before(:each) do
        put :update, id: @tasks.first.id, task: {title: "title", description: "fdfs"}
      end

      it { should respond_with(302)  }
      it { should redirect_to(@task) }
      it { should assign_to(:task)}
    end

    context "invalid data" do
      before(:each) do
        put :update, id: @tasks.first.id, task: {title: "", description: "fdfs"}
      end
    
      it { should respond_with(:success)  }
      it { should render_template(:edit) }
    end

    context "unauthorized user" do
       before(:each) do
        sign_out @users.first
        sign_in @users.last
        put :update, id: @tasks.first.id, task: {title: "title", description: "fdfs"}
      end
      it { should set_the_flash } 
      it { should respond_with(302)  }
      it { should redirect_to root_path }
    end
  end

  context "create" do
    context "saving task" do
      before(:each){post :create, task: {title: "title"}}
      it { should respond_with(302)  }
      it { should redirect_to root_path }
      it { should set_the_flash } 
    end

    context "not saving task" do
      before(:each){post :create, task: {title: ""}}
      it { should render_template('new')  }
      it { should respond_with(200) }
    end
  end

  context "states" do
    before(:each) do
      sign_out @users.first
      sign_in @users.last
    end

    context "finish" do
      before(:each) do
        Task.find(@tasks[0].id).fire_events(:apply)
        get :finish,  id: @tasks[0].id
      end

      it { subject.current_user.should_not be_nil}
      it { should redirect_to root_path  }
    end

    context "apply" do
      before(:each){ get :apply, id: @tasks[0].id}
    
      it { should redirect_to root_path }
    end

    context "cancel" do
      before(:each) do 
        Task.find_by_id(@tasks[0].id).update_attributes(state: "in_process")
        get :cancel, id: @tasks[0].id
      end

      it { should redirect_to root_path  }
      xit { expect{get :cancel, id: @tasks[0].id}.to change{Task.find(@tasks[0].id).state} }
    end
  end
end