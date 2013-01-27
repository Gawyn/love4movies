class RatingsController < ApplicationController
  def create
    @rating = Rating.create(:user_id => current_user.id,
      :movie_id => params[:movie_id], :value => params[:value])

    respond_to do |format|
      format.html { redirect_to :back } 
      format.js
    end
  end

  def update
    @rating = Rating.find(params[:id])

    if @rating.update_attribute(:value, params[:value])
      respond_to do |format|
        format.html { redirect_to :back } 
        format.js { render :create }
      end
    end
  end
end
