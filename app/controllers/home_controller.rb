class HomeController < ApplicationController
  def index
    if current_user
      @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids).includes(:user).includes(:content).order("created_at desc").limit(12)
      @users = User.more_experience_first.first(10)
    else
      @last_activity = Activity.last
    end
  end
end
