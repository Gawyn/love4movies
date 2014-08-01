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
    @total_pages = (Movie.not_hidden.more_ratings_than(2).count / Movie::MOVIES_PER_PAGE).ceil
    @movies = Movie.order("l4m_rating_average desc, id").not_hidden.more_ratings_than(2).page(params[:page]).per(Movie::MOVIES_PER_PAGE)
  end

  def recommended
    @order = params[:order] || "l4m_rating_average"
    @genre = params[:genre].blank? ? nil : params[:genre]
    @page = params[:page] || 1

    @searched_movies = get_recommended_movies

    @total_pages = (@searched_movies.count / Movie::MOVIES_PER_PAGE).ceil
    @movies = @searched_movies.page(@page).per(Movie::MOVIES_PER_PAGE)
  end

  def trending
    popular_movies_ids = Rating.where("created_at > ?", Time.now - 1.month).pluck(:movie_id).inject(Hash.new(0)) do |r, v|
      r[v] += 1
      r
    end.sort_by(&:last).reverse[0..19].map(&:first)

    @popular_movies = Movie.find(popular_movies_ids).index_by(&:id).values_at(*popular_movies_ids)
  end

  private

  def get_recommended_movies
    @movies = current_user ? Movie.where("movies.id not in (?)", current_user.ratings.pluck(:movie_id)) : Movie
    @movies = @movies.joins(:genres).where("genres.id = ?", @genre) if @genre
    @movies = @movies.more_total_ratings_than(15) if @order != "l4m_rating_average"

    if @order == "rating_average"
      @movies.order("rating_average desc", "id").where("rating_average is not null")
    else
      @movies.order("l4m_rating_average desc", "id").where("l4m_rating_average is not null")
    end
  end
end
