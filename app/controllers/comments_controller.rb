class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :movie_id)
  end
end
