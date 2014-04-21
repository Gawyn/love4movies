class FollowsController < ApplicationController
  def create
    @follow = Follow.create(follower_id: current_user.id, followed_id: params[:user_id]) if current_user
  end

  def destroy
    Follow.find(params[:id]).destroy
  end
end
