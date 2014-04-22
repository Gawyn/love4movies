class ActivitiesController < ApplicationController
  def index
    @page = params[:page] || 1

    @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids)
      .page(12).per(@page).padding(1).includes(:user).includes(:content)
      .order("created_at desc") if current_user
  end
end
