class HomeController < ApplicationController
  def index
    if current_user
      @followeds_activities = Activity.where(user_id: current_user.active_follows.pluck(:followed_id)).includes(:user).includes(:content).order("created_at desc").limit(12)
    end
  end
end
