class AddTriggeredOnToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :triggered_on_type, :string
    add_column :notifications, :triggered_on_id, :integer
  end
end
