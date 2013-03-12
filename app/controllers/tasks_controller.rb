class TasksController < ApplicationController
  load_and_authorize_resource

  def index 
    @users = User.all
  end

  def create
    @task.consumer_id = current_user.id
    if @task.save
      redirect_to root_path, notice: 'Task was successfully created.' 
    else
      render action: "new" 
    end
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render action: "edit" 
    end
  end

  def finish
    @task.finish!
    redirect_to root_path
  end
  
  def apply
    @task.apply!
    @task.doer_id = current_user.id
    @task.save
    redirect_to root_path
  end

  def cancel
    @task.doer_id = nil
    @task.save
    @task.cancel!
    redirect_to root_path
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  def show;end
  def new;end
  def edit;end
end
