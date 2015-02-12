class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_pending_notifications, :set_locale, :set_actual_url

  def set_locale
    I18n.locale = process_language
  end

  private

  def set_actual_url
    @actual_url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def process_language
    if valid_locale?(params[:set_locale])
      session["love4movies.locale"] = params[:set_locale]
      params[:set_locale]
    elsif valid_locale?(session["love4movies.locale"])
      session["love4movies.locale"]
    elsif request.env["HTTP_ACCEPT_LANGUAGE"]
      process_language_from_param(request.env["HTTP_ACCEPT_LANGUAGE"])
    else
      "en"
    end
  end

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

  def valid_locale?(locale)
    LOCALES.include? locale
  end
end
