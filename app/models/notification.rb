class Notification < ActiveRecord::Base
  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :pending, -> { where(pending: true) }

  validate :not_to_myself

  private

  def not_to_myself
    errors.add(:not_to_myself, "A user should not be notified by his own action") if user == notificable.user
  end
end
