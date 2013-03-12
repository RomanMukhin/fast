class TasksController < ApplicationController
  load_and_authorize_resource

<<<<<<< HEAD
  def index
    @tasks = Task.where('doer_id = ? AND consumer_id != ?',nil, current_user.id)
=======
  def index 
    @users = User.all
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
  end

  def create
    @task.consumer_id = current_user.id
    if @task.save
      redirect_to root_path, notice: 'Task was successfully created.' 
    else
<<<<<<< HEAD
      render :new
=======
      render action: "new" 
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
    end
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to @task, notice: 'Task was successfully updated.'
    else
<<<<<<< HEAD
      render :edit
=======
      render action: "edit" 
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
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

<<<<<<< HEAD
  def show
  end
  def new
  end
  def edit
  end
=======
  def show;end
  def new;end
  def edit;end
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
end
