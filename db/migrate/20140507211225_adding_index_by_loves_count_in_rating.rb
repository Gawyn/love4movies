class AddingIndexByLovesCountInRating < ActiveRecord::Migration
  def change
    add_index :ratings, [:movie_id, :loves_count]
    add_index :ratings, [:user_id, :loves_count]
    add_index :ratings, [:movie_id, :user_id, :loves_count]
  end
end
