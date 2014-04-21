class BadgesController < ApplicationController
  def index
    @badges = Badge.all

    @my_badges_ids = current_user.won_badges.pluck(:badge_id) if current_user
  end
end
