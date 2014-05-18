class ActivitiesController < ApplicationController
  def index
    @page = params[:page] || 1

    @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids)
      .page(@page).per(12).includes(:user).includes(:content)
      .order("created_at desc") if current_user
  end
end
