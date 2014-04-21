class Badge < ActiveRecord::Base
  has_many :movie_in_badges
  has_many :won_badges
  has_many :winners, through: :won_badges, source: :winner

  translates :name, :description

  def movies
    Movie.where(id: movie_ids)
  end

  def can_receive?(user)
    target_movie_quantity = movie_quantity || movie_ids.count
    user.ratings.where(movie_id: movie_ids).count >= target_movie_quantity
  end
end
