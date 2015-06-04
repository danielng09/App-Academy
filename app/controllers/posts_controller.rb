require 'byebug'

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

  def update
    @post = Post.find(params[:id])
    p @post
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
