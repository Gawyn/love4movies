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
    @order = params[:order] || "l4m_rating_average"
    @genre = params[:genre].blank? ? nil : params[:genre]
    @page = params[:page] || 1

    @searched_movies = get_recommended_movies

    @total_pages = (@searched_movies.count / Movie::RECOMMENDED_MOVIES_PER_PAGE).ceil
    @movies = @searched_movies.page(@page).per(Movie::RECOMMENDED_MOVIES_PER_PAGE)
  end

  private

  def get_recommended_movies
    @movies = Movie.where("movies.id not in (?)", current_user.ratings.pluck(:movie_id))
    @movies = @movies.joins(:genres).where("genres.id = ?", @genre) if @genre
    @movies = @movies.more_total_ratings_than(15) if @order == "l4m_rating_average"

    if @order == "rating_average"
      @movies.by_rating_average
    else
      @movies.by_l4m_rating_average
    end
  end
end
