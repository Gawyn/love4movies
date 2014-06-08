class MoviesController < ApplicationController
  def show
    @movie = Movie.includes(:reviews).find(params[:id]).decorate

    if current_user
      @my_rating = Rating.where(:user_id => current_user.id,
        :movie_id => @movie.id).first

      @ratings = @movie.ratings.most_loved_first.includes(:user)

      @loves = Love.where(lovable_type: "Rating", lovable_id: @ratings.map(&:id))
        .includes(:user).group_by(&:lovable_id)
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
    order = params[:order] || "l4m_rating_average"
    genre = params[:genre].blank? ? nil : params[:genre]

    @searched_movies = Movie.search do
      without(:id, current_user.ratings.pluck(:movie_id))
      order_by(order, :desc)
      with(:genre_ids, genre) if genre
      with(:total_ratings).greater_than(15) if order != "l4m_rating_average"
      paginate(:page => params[:page] || 1, :per_page => Movie::RECOMMENDED_MOVIES_PER_PAGE)
    end

    @total_pages = (@searched_movies.total.to_f / Movie::RECOMMENDED_MOVIES_PER_PAGE).ceil
    @movies = @searched_movies.results
    @order, @genre = order, genre
  end
end
