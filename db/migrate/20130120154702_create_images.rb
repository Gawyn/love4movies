class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :movie_id
      t.integer :width
      t.integer :height
      t.float :aspect_ratio
      t.string :file_path

      t.timestamps
    end
  end
end
