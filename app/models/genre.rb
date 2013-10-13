class Genre < ActiveRecord::Base
  validates_uniqueness_of :name, :tmdb_id

  has_and_belongs_to_many :movies
end
