class Friendship < ActiveRecord::Base
  after_create :create_reciprocal_friendship
  after_destroy :destroy_reciprocal_friendship

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validate :not_myself
  validates_uniqueness_of :user_id, :scope => :friend_id

  private

  def not_myself
    errors.add(:friendship, "A user can't befriend himself") if user.id == friend.id
  end

  def create_reciprocal_friendship
    Friendship.create(:user => friend, :friend => user) unless Friendship.find_by_user_id_and_friend_id(friend, user)
  end

  def destroy_reciprocal_friendship
    friendship = Friendship.find_by_user_id_and_friend_id(friend, user)
    friendship.destroy if friendship
  end
end
