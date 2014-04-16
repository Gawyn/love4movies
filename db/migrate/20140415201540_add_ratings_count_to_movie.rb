class AddRatingsCountToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :ratings_count, :integer, default: 0

    Rating.pluck(:movie_id).each do |movie_id|
      Movie.reset_counter(:ratings_count, movie_id)
    end
  end
end
