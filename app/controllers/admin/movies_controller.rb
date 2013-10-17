class Admin::MoviesController < Admin::AdminController
  def hidden
    @movies = Movie.hidden.by_popularity
  end
end
