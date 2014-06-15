class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:reviews).find(params[:id]).decorate
    @ratings = @movie.ratings.most_loved_first.includes(:user)

    @loves = Love.where(lovable_type: "Rating", lovable_id: @ratings.map(&:id))
      .includes(:user).group_by(&:lovable_id)

    if current_user
      @my_rating = Rating.where(:user_id => current_user.id,
        :movie_id => @movie.id).first
    end
  end

  def index
    BackgroundSystem.enqueue(MovieSearcher, params[:search]) if params[:search]
    @movies = Movie.standard_search(params[:search]).results
  end

  def ranking
    @movies = Movie.by_l4m_rating_average.not_hidden.more_ratings_than(2).page(params[:page])
  end

  def recommended
    order = params[:order] || "popularity"
    genre = params[:genre].blank? ? nil : params[:genre]

    @movies = Movie.search do
      without(:id, current_user.ratings.pluck(:movie_id))
      order_by(order, :desc)
      with(:genre_ids, genre) if genre
    end.results
  end
end
