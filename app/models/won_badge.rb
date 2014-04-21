class WonBadge < ActiveRecord::Base
  belongs_to :winner, class_name: "User"
  belongs_to :badge

  validates_inclusion_of :winner_id, :badge_id
  validates_uniqueness_of :winner_id, scope: :badge_id
end
