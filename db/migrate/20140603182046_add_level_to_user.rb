class AddLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :level, :integer, default: 1

    User.all.each do |user|
      level = Experience::SUM_LEVEL_EXPERIENCE.index { |xp_of_level| user.experience < xp_of_level } + 1

      user.update_attribute(:level, level) if user.level != level
    end
  end
end
