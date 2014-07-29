class HomeController < ApplicationController
  def index
    @type = "activities"
    if current_user
      @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids).includes(:user).includes(:content).order("created_at desc").limit(12)
      @users = User.more_experience_first.first(10)
    else
      @last_activity = Activity.last
      render layout: "landing"
    end
  end
end
