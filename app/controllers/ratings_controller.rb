class RatingsController < ApplicationController
  def create
    Rating.create(:user_id => current_user.id,
      :movie_id => params[:movie_id], :value => params[:value])

    @movie = Movie.find params[:movie_id]

    respond_to do |format|
      format.html { redirect_to :back } 
      format.js
    end
  end
end
