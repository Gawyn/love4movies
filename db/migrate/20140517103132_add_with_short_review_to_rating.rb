class AddWithShortReviewToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :with_short_review, :boolean, default: false
    add_index :ratings, :with_short_review

    Rating.all.each do |rating|
      rating.update_attribute(:with_short_review, rating.short_review.present?)
    end
  end
end
