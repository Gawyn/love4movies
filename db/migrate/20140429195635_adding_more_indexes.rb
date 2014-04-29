class AddingMoreIndexes < ActiveRecord::Migration
  def change
    add_index :activities, :user_id
    add_index :comments, [:commentable_type, :commentable_id]
    add_index :genres_movies, :genre_id
    add_index :genres_movies, :movie_id
    add_index :notifications, :user_id
    add_index :notifications, [:user_id, :pending]
    add_index :ratings, :movie_id
    add_index :ratings, :user_id
    add_index :reviews, :movie_id
    add_index :reviews, :user_id
    add_index :won_badges, :winner_id
    add_index :won_badges, [:badge_id, :winner_id]
  end
end
