class Activity < ActiveRecord::Base
  ACTIVITY_TYPES = [Comment, Rating]

  belongs_to :content, polymorphic: true
  belongs_to :user
end
