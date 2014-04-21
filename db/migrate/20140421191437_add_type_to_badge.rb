class AddTypeToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :type, :string
  end
end
