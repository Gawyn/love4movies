class AddL4mRatingAverageToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :l4m_rating_average, :float
    Rating.pluck(:movie_id).uniq.each do |movie_id|
      movie = Movie.find movie_id
      movie.update_attribute(:l4m_rating_average, movie.ratings.pluck(:value).sum.to_f/movie.ratings.count)
    end
  end
end
