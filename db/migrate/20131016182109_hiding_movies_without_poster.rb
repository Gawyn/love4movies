class HidingMoviesWithoutPoster < ActiveRecord::Migration
  def change
    Movie.where("tmdb_poster_path is null").update_all(hidden: false)
  end
end
