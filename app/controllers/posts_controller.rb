class PostsController < ApplicationController
  before_action :check_if_author, only: [:edit, :update]

  def new
    @subs = Sub.all
    @post = Post.new
  end

  def create
    @subs = Sub.all
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
  end

  def update
    @subs = Sub.all
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id, :sub_ids => [])
  end

  def check_if_author
    post = Post.find(params[:id])
    unless current_user == post.author
      redirect_to post_url(post)
    end
  end

end
