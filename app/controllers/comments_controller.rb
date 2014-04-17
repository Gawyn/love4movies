class CommentsController < ApplicationController
  def create
    @comment = if params[:rating_id]
      Comment.create(commentable_type: "Rating", commentable_id: params[:rating_id], content: params[:content], user_id: current_user.id)
    elsif params[:review_id]
      Comment.create(commentable_type: "Review", commentable_id: params[:review_id], content: params[:content], user_id: current_user.id)
    else
      nil
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
