class MovieInBadge < ActiveRecord::Base
  belongs_to :movie
  belongs_to :badge
end
