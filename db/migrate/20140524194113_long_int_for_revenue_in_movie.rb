class LongIntForRevenueInMovie < ActiveRecord::Migration
  def change
    change_column :movies, :revenue, :integer, limit: 8
  end
end
