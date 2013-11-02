class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :content_type
      t.integer :content_id

      t.timestamps
    end
  end
end
