class AddTaglineToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :tagline, :string
  end
end
