class CreateLoves < ActiveRecord::Migration
  def change
    create_table :loves do |t|
      t.integer :user_id
      t.string :lovable_type
      t.integer :lovable_id

      t.timestamps
    end

    add_index :loves, [:user_id, :lovable_type, :lovable_id]
    add_index :loves, [:lovable_type, :lovable_id]
  end
end
