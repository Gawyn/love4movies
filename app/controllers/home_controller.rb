class HomeController < ApplicationController
  def index
    if current_user
      redirect_to timeline_path
    else
      @last_activity = Activity.last
      render layout: "landing"
    end
  end

  def timeline
    redirect_to root_path unless current_user

    @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids).includes(:user).includes(:content).order("created_at desc").limit(12)
  end
end
