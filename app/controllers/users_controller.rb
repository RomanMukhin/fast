class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end
  
  def create
    if @user.save
      redirect_to @user, notice: 'User was successfully created.' 
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy 
    @user.destroy
    redirect_to root_path, notice: 'User was successfully destroyed.' 
  end

  def show
    @offers = Task.where('doer_id IS NULL AND consumer_id = ?', @user.id)
  end
  def new
  end
  def edit
  end
end
