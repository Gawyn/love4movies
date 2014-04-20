class WonBadge < ActiveRecord::Base
  belongs_to :winner, class_name: "User"
  belongs_to :badge
end
