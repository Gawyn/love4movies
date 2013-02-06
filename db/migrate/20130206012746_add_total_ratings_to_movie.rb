class AddTotalRatingsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :total_ratings, :integer, :default => 0
    Movie.all.each do |movie|
      movie.update_attribute(:total_ratings, movie.ratings.count + movie.tmdb_vote_count)
    end
  end
end
