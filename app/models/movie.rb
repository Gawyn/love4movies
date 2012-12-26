class Movie < ActiveRecord::Base
  attr_accessible :budget, :imdb_id, :original_title, :overview, 
    :popularity, :release_date, :revenue, :runtime, :tmdb_id, 
    :tmdb_vote_average, :tmdb_vote_count
end
