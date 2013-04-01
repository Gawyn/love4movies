class AddRatingsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :ratings_count, :integer, :default => 0

    User.pluck(:id).each do |user_id|
      User.reset_counters(user_id, :ratings)
    end
  end
end
