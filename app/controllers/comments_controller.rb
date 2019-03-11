class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.article = Article.find(params[:article_id])
    @comment.user = current_user
    if @comment.save
      render :create_success
    else
      render :create_error
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end
