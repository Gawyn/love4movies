class Activity < ActiveRecord::Base
  ACTIVITY_TYPES = [Comment, Rating]

  belongs_to :content, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :content_id, scope: [:content_type, :user_id]
  validates_presence_of :user_id, :content
end
