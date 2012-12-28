class Movie < ActiveRecord::Base
  attr_accessible :budget, :imdb_id, :original_title, :overview, 
    :popularity, :release_date, :revenue, :runtime, :tmdb_id, 
    :tmdb_vote_average, :tmdb_vote_count

  validates_uniqueness_of :tmdb_id

  has_many :participations
  has_many :people, :through => :participations
end
