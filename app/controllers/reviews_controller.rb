class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :movie_id)
  end
end
