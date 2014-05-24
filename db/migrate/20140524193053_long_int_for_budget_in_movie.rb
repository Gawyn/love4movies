class LongIntForBudgetInMovie < ActiveRecord::Migration
  def change
    change_column :movies, :budget, :integer, limit: 8
  end
end
