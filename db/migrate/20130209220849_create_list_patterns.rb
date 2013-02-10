class CreateListPatterns < ActiveRecord::Migration
  def change
    create_table :list_patterns do |t|
      t.string :title

      t.timestamps
    end
  end
end
