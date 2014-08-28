class AddAdultToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :adult, :boolean, default: false
  end
end
