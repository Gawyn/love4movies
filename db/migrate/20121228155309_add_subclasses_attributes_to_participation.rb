class AddSubclassesAttributesToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :type, :string
    add_column :participations, :character, :string
    add_column :participations, :tmdb_order, :integer
    add_column :participations, :department, :string
    add_column :participations, :job, :string
  end
end
