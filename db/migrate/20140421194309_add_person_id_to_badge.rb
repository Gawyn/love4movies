class AddPersonIdToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :person_id, :integer
  end
end
