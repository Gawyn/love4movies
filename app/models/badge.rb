class Badge < ActiveRecord::Base
  has_many :movie_in_badges
  has_many :movies, through: :movie_in_badges
  has_many :won_badges
  has_many :winners, through: :won_badges, source: :winner

  translates :name, :description

  def can_receive?(user)
    target_movie_quantity = movie_quantity || movie_in_badges.count
    user.ratings.where(movie_id: movie_in_badges.pluck(:movie_id)).count >= target_movie_quantity
  end
end
