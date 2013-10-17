class ChangeDefaultValueOfHiddenToTrue < ActiveRecord::Migration
  def change
    change_column :movies, :hidden, :boolean, default: true
  end
end
