class SettingExperience < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.update_attribute(:experience, user.ratings.pluck(:loves_count).compact.sum +
        (user.ratings.with_short_review.count * 2) + 
        user.ratings.without_short_review.count)
    end
  end
end
