class DestroyEgocentricFollows < ActiveRecord::Migration
  def change
    Follow.all.each do |follow|
      follow.destroy if follow.follower_id == follow.followed_id
    end
  end
end
