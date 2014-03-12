class Comment < ActiveRecord::Base
  COMMENTABLE_TYPES = ["Rating", "Review"]

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :user_id, :content, :commentable_id,
    :commentable_type
  validates_inclusion_of :commentable_type, in: COMMENTABLE_TYPES
end
