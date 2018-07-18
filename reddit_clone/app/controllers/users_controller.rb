class UsersController < ApplicationController
  
  def index 
    @users = User.all
  end 
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else 
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user 
      @user.destroy
      redirect_to new_session_url
    else 
      flash[:errors] = ['Cannot find user']
      redirect_to users_url
    end 
  end 
  
  def edit 
    @user = User.find(params[:id])
  end 
  
  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else 
      flash.now[:errors] = ['Cannot update']
      render :edit
    end 
  end 
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
