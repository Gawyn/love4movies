class AddExtraInformationToPeople < ActiveRecord::Migration
  def change
    add_column :people, :place_of_birth, :string
    add_column :people, :birthday, :date
    add_column :people, :deathday, :date
  end
end
