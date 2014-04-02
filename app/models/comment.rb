class Comment < ActiveRecord::Base
  COMMENTABLE_TYPES = ["Rating", "Review"]

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :user_id, :content, :commentable_id,
    :commentable_type
  validates_inclusion_of :commentable_type, in: COMMENTABLE_TYPES

  after_create :notify!

  private

  def notify!
    Notification.create(user: commentable.user, notificable: self) if user != commentable.user

    last_comment = commentable.comments.last
    Notification.create(user: last_comment.user, notificable: last_comment) if last_comment && user != last_comment.user
  end
end
