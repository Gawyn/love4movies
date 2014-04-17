class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_pending_notifications, :set_locale

  def set_locale
    http_lang = request.env["HTTP_ACCEPT_LANGUAGE"]

    I18n.locale = http_lang ? process_language_from_param(http_lang) : "es"
  end

  private

  def check_pending_notifications
    @pending_notifications = current_user.notifications.pending if current_user
  end

  def process_language_from_param(language_param)
    browser_language = language_param.scan(/^[a-z]{2}/).first

    case browser_language
    when "es", "ca" then "es"
    else "en"
    end
  end
end
