class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_pending_notifications

  private

  def check_pending_notifications
    @pending_notifications = current_user.notifications.pending if current_user
  end
end
