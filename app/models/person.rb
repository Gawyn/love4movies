class Person < ActiveRecord::Base
  validates_uniqueness_of :tmdb_id

  has_many :participations
  has_many :movies, :through => :participations

  has_many :images, as: :owner, :dependent => :destroy
  has_many :profiles, as: :owner

  searchable do
    text :name
  end
end
