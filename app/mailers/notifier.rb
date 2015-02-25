class Notifier < ActionMailer::Base
  default from: "love4movies@love4movies.com"
  default_url_options[:host] = "http://love4movies.com"

  def notification(notification)
    @notification = notification.decorate

    mail(to: notification.triggered_on.user.email, subject: @notification.sanitized_title)
  end
end
