class PostsController < ApplicationController
  before_action :restrict?, only: [:new, :create]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "Post successfully created"
      redirect_to posts_path
    else
      flash.now[:error] = "Please enter the required information"
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end
  
  private
  def restrict?
    redirect_to login_path unless logged_in?
  end
  
  def user_params
    params.require(:post).permit(:title, :body)
  end
  
end
