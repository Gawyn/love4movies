class AddRatingsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :ratings_count, :integer, :default => 0

    User.all.each do |user|
      User.reset_counters(user.id, :ratings)
    end
  end
end
