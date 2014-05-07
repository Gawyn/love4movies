class SettingDefaultForLovesCount < ActiveRecord::Migration
  def change
    change_column :ratings, :loves_count, :integer, default: 0
  end
end
