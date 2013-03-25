class AddRatingsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :ratings_count, :integer, :default => 0

    User.all.each do |user|
      user.update_attribute(:ratings_count, user.ratings.count)
    end
  end
end
