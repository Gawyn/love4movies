class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:comments).find(params[:id])
    @my_rating = Rating.where(:user_id => current_user.id,
      :movie_id => @movie.id).first if current_user
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
