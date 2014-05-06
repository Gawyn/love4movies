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

      @loves = Love.where(lovable_type: "Rating", lovable_id: @movie.ratings.pluck(:id))
        .includes(:user).group_by(&:lovable_id)
    end
  end

  def index
    BackgroundSystem.enqueue(MovieSearcher, params[:search]) if params[:search]
    @movies = Movie.standard_search(params[:search])
  end

  def ranking
    @movies = Movie.by_l4m_rating_average.not_hidden.more_ratings_than(2).page(params[:page])
  end
end
