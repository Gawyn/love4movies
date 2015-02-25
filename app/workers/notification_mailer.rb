class NotificationMailer
  include Sidekiq::Worker

  def perform(notification_id)
    # Should be changed in the future for the user's locale.
    I18n.locale = :en

    notification = Notification.find notification_id

    Notifier.send(:notification, notification).deliver
  end
end
