class Notification < ActiveRecord::Base
  belongs_to :notificable, polymorphic: true
  belongs_to :triggered_on, polymorphic: true
  belongs_to :user

  scope :pending, -> { where(pending: true) }
  scope :newest_first, -> { order("created_at desc") }

  validate :not_to_myself

  after_commit :notify_by_mail, on: :create

  private

  def not_to_myself
    errors.add(:not_to_myself, "A user should not be notified by his own action") if user == notificable.user
  end

  def notify_by_mail
    NotificationMailer.perform_async(id)
  end
end
