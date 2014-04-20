class CreateWonBadges < ActiveRecord::Migration
  def change
    create_table :won_badges do |t|
      t.integer :winner_id
      t.integer :badge_id

      t.timestamps
    end
  end
end
