require 'spec_helper'

describe  TasksController do
  before(:each) do
    @task = FactoryGirl.create(:task)
  end
  let(:valid_task)  {FactoryGirl.attributes_for(:valid_task)  }
  let(:invalid_task){FactoryGirl.attributes_for(:invalid_task)}

  context "authorized user" do
    before(:each) do
      sign_in @task.consumer
    end

    context "update" do
      context "with valid data" do
        
        before(:each) do
          put :update, id: @task.consumer.id, task: valid_task
        end

        it { should respond_with(302)  }
        it { should redirect_to(@task) }
        it { should assign_to( :task)   }
      end

      context "with invalid data" do
        before(:each) do
          put :update, id: @task.consumer.id, task: invalid_task
        end
      
        it { should respond_with(:success)  }
        it { should render_template(:edit) }
      end
    end

    context "index" do
    	before(:each){ get :index }
      it { subject.current_user.should_not be_nil}
      it { should assign_to(:tasks) }
      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should_not set_the_flash } 
    end

    context "show" do	
      before(:each) {get :show, id: @task.consumer.id}
      
      it { subject.current_user.should_not be_nil}
      it { should assign_to(:task) }
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }	
    end
    context "edit" do
      before(:each) do
        get :edit, id: @task.consumer.id
      end

      it { should respond_with(:success)  }
      it { should render_template(:edit) }
      it { should assign_to(:task)}
    end
  end

  context "unauthorized user" do
    before(:each) do 
      sign_in @task.doer
    end
    
    context "edit" do
      before(:each) do
        get :edit, id: @task.consumer.id
      end

      it { should_not respond_with(:success)  }
      it { should redirect_to root_path }
    end

    context "update" do
      before(:each) do
        put :update, id: @task.consumer.id, task: @valid_task
      end
      it { should set_the_flash } 
      it { should respond_with(302)  }
      it { should redirect_to root_path }
    end
  end

  context "redirects to index if no rights" do
    before(:each) do
      sign_in @task.doer
    end

    [:finish, :apply, :cancel].each do |action|
      context "#{action}" do
        before(:each) do
          @task.apply! unless action == :apply
          send :get, action, id: @task.id
        end
        it { should redirect_to root_path }
      end
    end
  end
end