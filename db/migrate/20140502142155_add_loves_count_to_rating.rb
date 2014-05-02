class AddLovesCountToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :loves_count, :integer
  end
end
