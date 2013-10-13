class Person < ActiveRecord::Base
  validates_uniqueness_of :tmdb_id

  has_many :participations
  has_many :movies, :through => :participations
end
