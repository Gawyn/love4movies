class FollowsController < ApplicationController
  def create
    followed_user = User.find_by_nickname params[:user_id]
    @follow = Follow.create(follower_id: current_user.id, followed_id: followed_user.id) if current_user
  end

  def destroy
    @follow = Follow.find(params[:id])
    @followed_id = @follow.followed_id
    @follow.destroy
  end
end
