class AddingIndexes < ActiveRecord::Migration
  def change
    add_index :images, [:type, :owner_id, :owner_type]
    add_index :participations, [:type, :movie_id, :job]
    add_index :follows, :follower_id
  end
end
