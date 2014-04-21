class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name_es
      t.string :name_en
      t.text :description_es
      t.text :description_en
      t.integer :movie_quantity

      t.timestamps
    end
  end
end
