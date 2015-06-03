class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: @post
  end

end
