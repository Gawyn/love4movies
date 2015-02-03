class ChangeReleaseDateTypeInMovie < ActiveRecord::Migration
  def up
    change_column :movies, :release_date, 'date USING CAST(release_date AS date)'
  end

  def down
    change_column :movies, :release_date, :string
  end
end
