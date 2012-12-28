class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :movie_id
      t.integer :person_id

      t.timestamps
    end
  end
end
