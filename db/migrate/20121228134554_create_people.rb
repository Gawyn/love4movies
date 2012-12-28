class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :tmdb_profile_path
      t.integer :tmdb_id

      t.timestamps
    end
  end
end
