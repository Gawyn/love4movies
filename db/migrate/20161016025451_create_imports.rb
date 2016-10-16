class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :user_id
      t.boolean :completed
      t.integer :rating_id
      t.string :status
      t.string :rated_title
      t.integer :rated_value
      t.integer :rated_year
      t.string :rated_director
      t.string :rated_source

      t.timestamps
    end
  end
end
