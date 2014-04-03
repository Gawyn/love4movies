class NotificationsController < ApplicationController
  def index
    redirect_to root_path unless current_user

    @notifications = current_user.notifications.newest_first
    current_user.notifications.pending.update_all(pending: false)
  end
end
