class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end
