class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.create(title: params[:post][:title], body: params[:post][:body], author: current_user.id)
    redirect_to posts_url
  end

  def index
    @posts = Post.all
  end
end
