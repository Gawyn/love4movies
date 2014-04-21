class MovieInBadge < ActiveRecord::Base
  belongs_to :movie
  belongs_to :badge

  validates_presence_of :movie_id, :badge_id
  validates_uniqueness_of :movie_id, scope: :badge_id
end
