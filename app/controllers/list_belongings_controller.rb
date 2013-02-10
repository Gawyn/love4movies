class ListBelongingsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id]).decorate
    ListBelonging.create(:list_id => params[:list_id], :movie_id => @movie.id)
  end

  def destroy
    @list_belonging = ListBelonging.where(:list_id => params[:list_id], :movie_id => params[:movie_id]).first
    @list_belonging.destroy
  end
end
