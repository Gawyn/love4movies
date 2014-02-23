class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:comments).find(params[:id]).decorate
    @my_rating = Rating.where(:user_id => current_user.id,
      :movie_id => @movie.id).first if current_user
  end

  def index
    BackgroundSystem.enqueue(MovieSearcher, params[:search]) if params[:search]
    @movies = (params[:search] ? Movie.search(params[:search].gsub(" ", "_")) : Movie).not_hidden
  end

  def ranking
    @movies = Movie.by_rating_average.not_hidden.more_total_ratings_than(3).decorate
  end
end
