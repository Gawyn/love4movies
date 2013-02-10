class AddListPatternIdToList < ActiveRecord::Migration
  def change
    add_column :lists, :list_pattern_id, :integer
  end
end
