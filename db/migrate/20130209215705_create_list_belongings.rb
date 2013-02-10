class CreateListBelongings < ActiveRecord::Migration
  def change
    create_table :list_belongings do |t|
      t.integer :movie_id
      t.integer :list_id

      t.timestamps
    end
  end
end
