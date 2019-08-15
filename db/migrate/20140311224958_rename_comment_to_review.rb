class RenameCommentToReview < ActiveRecord::Migration
  def change
    # This migration changed its original purpose, now it creates the reviews table
    create_table "reviews", force: true do |t|
      t.integer  "user_id"
      t.integer  "movie_id"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
