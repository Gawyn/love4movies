class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def index
    @movies = if params[:search]
      TMDBFeeder.generate_movies(params[:search])
      Movie.where(Movie.arel_table[:title].matches("%#{params[:search]}%"))
    else
      Movie.all
    end
  end
end
