class Badge < ActiveRecord::Base
  has_many :movie_in_badges
  has_many :movies, through: :movie_in_badges
  has_many :won_badges
  has_many :winners, through: :won_badges, source: :winner

  translates :name, :description

  def can_receive?(user)
    target_movie_quantity = movie_quantity || movies.count
    ratings_for_badge = user.ratings.where(movie_id: movie_in_badges.pluck(:movie_id)).with_short_review.count 

    ratings_for_badge >= target_movie_quantity
  end
end
