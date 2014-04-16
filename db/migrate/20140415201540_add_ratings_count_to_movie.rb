class AddRatingsCountToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :ratings_count, :integer, default: 0

    Rating.pluck(:movie_id).each do |movie_id|
      Movie.reset_counters(movie_id, :ratings)
    end
  end
end
