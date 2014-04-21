class CreateMovieInBadges < ActiveRecord::Migration
  def change
    create_table :movie_in_badges do |t|
      t.integer :movie_id
      t.integer :badge_id

      t.timestamps
    end
  end
end
