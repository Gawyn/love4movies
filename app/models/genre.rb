class Genre < ActiveRecord::Base
  attr_accessible :name, :tmdb_id

  validates_uniqueness_of :name, :tmdb_id
end
