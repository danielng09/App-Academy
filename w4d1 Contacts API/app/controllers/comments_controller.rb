class CommentsController < ApplicationController
  def index
    render json: find_commentable.comments
  end

  def show
    render json: Comment.find(params[:id])
  end

  def create
    @commentable = find_commentable
    comment = @commentable.comments.new(comment_params)
    if comment.save
      render json: comment
    else
      render(json: comment.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
