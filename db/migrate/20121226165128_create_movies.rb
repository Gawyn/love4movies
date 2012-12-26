class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :tmdb_id
      t.string :imdb_id
      t.string :original_title
      t.string :title
      t.string :release_date
      t.integer :budget
      t.text :overview
      t.float :tmdb_vote_average
      t.integer :tmdb_vote_count
      t.integer :runtime
      t.integer :revenue
      t.float :popularity
      t.string :tmdb_poster_path

      t.timestamps
    end
  end
end
