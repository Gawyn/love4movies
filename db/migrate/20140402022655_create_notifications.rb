class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notificable_id
      t.string :notificable_type
      t.integer :user_id
      t.boolean :pending, default: true

      t.timestamps
    end
  end
end
