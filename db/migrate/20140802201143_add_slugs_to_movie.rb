class AddSlugsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :slug, :string

    Movie.find_each do |movie|
      movie.set_slug
      movie.save!
    end
  end
end
