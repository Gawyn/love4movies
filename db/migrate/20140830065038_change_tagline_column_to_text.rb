class ChangeTaglineColumnToText < ActiveRecord::Migration
  def change
    change_column :movies, :tagline, :text
  end
end
