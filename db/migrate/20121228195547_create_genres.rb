class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.integer :tmdb_id
      t.string :name

      t.timestamps
    end
  end
end
