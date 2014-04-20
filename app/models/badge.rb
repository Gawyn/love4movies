class Badge < ActiveRecord::Base
  has_many :movie_in_badges
  has_many :movies, through: :movie_in_badges
  has_many :won_badges
  has_many :winners, through: :won_badges, source: :winner

  translates :name, :description
end
