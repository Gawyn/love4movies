class Person < ActiveRecord::Base
  attr_accessible :name, :tmdb_profile_path, :tmdb_id

  validates_uniqueness_of :tmdb_id

  has_many :participations
  has_many :movies, :through => :participations
end
