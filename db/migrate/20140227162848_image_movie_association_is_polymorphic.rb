class ImageMovieAssociationIsPolymorphic < ActiveRecord::Migration
  def change
    rename_column :images, :movie_id, :owner_id
    add_column :images, :owner_type, :string

    Image.update_all(owner_type: "Movie")
  end
end
