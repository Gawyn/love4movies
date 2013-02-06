class AddHiddenToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :hidden, :boolean, :default => false
  end
end
