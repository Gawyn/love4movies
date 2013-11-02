class FollowsController < ApplicationController
  def create
    @follow = Follow.create(followed_id: current_user.id, follower_id: params[:user_id]) if current_user
  end
end
