class PostsController < ApplicationController
  before_action :require_login
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id 
    
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update_attributes(post_params)
      redirect_to sub_posts_url
    else 
      flash.now[:errors] = ['Cannot Update']
      render :edit 
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_posts_url
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
