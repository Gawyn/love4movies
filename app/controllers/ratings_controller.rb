class RatingsController < ApplicationController
  def create
    @my_rating = Rating.find_by_user_id_and_movie_id(current_user.id,
      params[:movie_id])

    if @my_rating
      @my_rating.update_attribute(:value, params[:value])
    else
      @my_rating = Rating.create(:user_id => current_user.id,
        :movie_id => params[:movie_id], :value => params[:value])
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @rating = Rating.find params[:id]

    if @rating.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end
