class Person < ActiveRecord::Base
  validates_uniqueness_of :tmdb_id

  has_many :participations
  has_many :movies, :through => :participations

  has_many :images, as: :owner, :dependent => :destroy
  has_many :posters, as: :owner
  has_many :backdrops, as: :owner
end
