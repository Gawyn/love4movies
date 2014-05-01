class AddShortReviewToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :short_review, :text
  end
end
