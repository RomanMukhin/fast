class UsersController < ApplicationController
  load_and_authorize_resource

  def index
<<<<<<< HEAD
    if user_signed_in?
=======
    if current_user
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
      @user = User.find(current_user.id)
    end
  end
  
  def create
    if @user.save
      redirect_to @user, notice: 'User was successfully created.' 
    else
<<<<<<< HEAD
      render :new
=======
      render action: "new" 
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.' 
    else
<<<<<<< HEAD
      render :edit
=======
      render action: "edit" 
>>>>>>> e8e05bf50d96596ca50a0053b0f073662898b105
    end
  end

  def destroy 
    @user.destroy
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
