class ListBelongingsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id]).decorate
    ListBelonging.create(:list_id => params[:list_id], :movie_id => @movie.id)
  end
end
