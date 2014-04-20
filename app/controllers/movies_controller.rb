class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:reviews).find(params[:id]).decorate

    if current_user
      @my_rating = Rating.where(:user_id => current_user.id,
        :movie_id => @movie.id).first

      @friends_ratings = Rating.where(user_id: current_user.followed_users_and_me_ids,
        movie_id: @movie.id).newest_first.includes(:user)

      @all_ratings = @movie.ratings.where("user_id not in (?)", 
        current_user.followed_users_and_me_ids).newest_first.includes(:user)
    end
  end

  def index
    BackgroundSystem.enqueue(MovieSearcher, params[:search]) if params[:search]
    @movies = (params[:search] ? Movie.search(params[:search].gsub(" ", "_")) : Movie).not_hidden.more_total_ratings_than(0)
  end

  def ranking
    @movies = Movie.by_l4m_rating_average.not_hidden.more_ratings_than(1).page(params[:page])
  end
end
