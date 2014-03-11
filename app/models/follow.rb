class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates_uniqueness_of :follower_id, scope: :followed_id
  validates_presence_of :follower_id, :followed_id
  validate :follower_and_followed_are_different

  private

  def follower_and_followed_are_different
    errors.add(:not_following_yourself, "A user can't follow himself") if follower_id == followed_id
  end
end
