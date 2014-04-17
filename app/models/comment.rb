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
    return if user == commentable.user
    
    notificable = commentable.comments.where.not(id: id).last || commentable
    Notification.create(user: notificable.user, notificable: notificable)
  end
end
