class PostsController < ApplicationController
  before_action :restrict?, only: [:new, :create]
  
  def new
    @post = @current_user.posts.new
  end

  def create
  end

  def index
    @posts = Post.all
  end
  
  private
  def restrict?
    redirect_to login_path unless logged_in?
  end
  
end
