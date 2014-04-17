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
    Notification.create(user: commentable.user, notificable: self, triggered_on: commentable) if user != commentable.user

    last_comment = commentable.comments.where.not(id: id).last
    Notification.create(user: last_comment.user, notificable: self, triggered_on: last_comment) if last_comment && user != last_comment.user && last_comment.user != commentable.user
  end
end
