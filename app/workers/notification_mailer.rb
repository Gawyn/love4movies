class NotificationMailer
  include Sidekiq::Worker

  def perform(notification_id)
    notification = Notification.find notification_id

    message_params = {
      from: "Stanley Kubrick",
      to: notification.triggered_on.user.email,
      subject: notification.decorate.sanitized_title,
      text: ""
    }

    MailgunClient.send_message "love4movies.com", message_params
  end
end
