class Movie < ActiveRecord::Base
  attr_accessible :budget, :imdb_id, :original_title, :overview, 
    :popularity, :release_date, :revenue, :runtime, :tmdb_id, 
    :tmdb_vote_average, :tmdb_vote_count, :rating_average

  validates_uniqueness_of :tmdb_id

  has_many :participations
  has_many :performances
  has_many :technical_participations
  has_many :people, :through => :participations
  has_many :actors, :through => :performances, :source => :person
  has_many :technical_members, :through => :technical_participations, :source => :person
  has_and_belongs_to_many :genres
  has_many :ratings

  def calculate_rating_average
    if ratings.any?
      total_ratings = ratings.count
      my_ratings_average = ratings.pluck(:value).sum.to_f/total_ratings
      (my_ratings_average * total_ratings + tmdb_vote_average * tmdb_vote_count) / total_ratings + tmdb_vote_count
    else
      tmdb_vote_average / tmdb_vote_count
    end
  end
end
