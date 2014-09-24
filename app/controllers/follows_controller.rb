class FollowsController < ApplicationController
  def create
    @follow = Follow.create(follower_id: current_user.id, followed_id: params[:user_id]) if current_user
  end

  def destroy
    @follow = Follow.find(params[:id])
    @followed_id = @follow.followed_id
    @follow.destroy
  end
end
