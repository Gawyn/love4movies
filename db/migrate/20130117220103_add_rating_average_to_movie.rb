class AddRatingAverageToMovie < ActiveRecord::Migration
  def up
    add_column :movies, :rating_average, :float
    Movie.all.each do |movie|
      movie.update_attribute(:rating_average, movie.tmdb_vote_average)
    end
  end

  def down
    remove_column :movies, :rating_average
  end
end
