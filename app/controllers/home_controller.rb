class HomeController < ApplicationController
  def index
    if current_user
      @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids).includes(:user).includes(:content).order("created_at desc").limit(13)
    else
      @last_activity = Activity.last
    end
  end
end
