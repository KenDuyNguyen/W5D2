class SubsController < ApplicationController
  
  before_action :require_login, except: [:index, :show]
  
  def index 
    @subs = Sub.all
  end 
  
  def show 
    @sub = Sub.find(params[:id])
  end 
  
  def new 
    @sub = Sub.new
  end 
  
  def create 
    @sub = Sub.new(sub_params)
    @sub.mod_id = current_user.id
    
    if @sub.save
      redirect_to sub_url(@sub)
    else 
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end 
  end 
  
  def edit 
    @sub = Sub.find(params[:id])
  end 
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Could not update"]
      render :edit
    end
  end 
  
  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy 
    redirect_to subs_url
  end 
  
  private
  
  def sub_params 
    params.require(:sub).permit(:title, :description)
  end 
end
