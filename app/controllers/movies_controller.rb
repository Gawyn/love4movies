class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:reviews).find(params[:id]).decorate

    if current_user
      @my_rating = Rating.where(:user_id => current_user.id,
        :movie_id => @movie.id).first

      @ratings = @movie.ratings.newest_first.includes(:user)

      @loves = Love.where(lovable_type: "Rating", lovable_id: @ratings.map(&:id))
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
