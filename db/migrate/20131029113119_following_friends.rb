class FollowingFriends < ActiveRecord::Migration
  def change
    Friendship.all.each do |friendship|
      Follow.create(followed_id: friendship.user_id, follower_id: friendship.friend_id)
    end
  end
end
