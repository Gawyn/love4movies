class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    User.update_all(role: "user")
  end
end
