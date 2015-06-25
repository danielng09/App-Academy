class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(comment_params[:post_id])
    else
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @child_comments = @comment.child_comments
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :author_id, :post_id, :parent_comment_id)
  end
end
