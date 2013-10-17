class InternationalizeMovies < ActiveRecord::Migration
  def up
    LOCALES.each do |locale|
      add_column :movies, "title_#{locale}", :string
      add_column :movies, "overview_#{locale}", :text
    end

    Movie.all.each do |movie|
      movie.update_attribute(:title_en, movie.title)
      movie.update_attribute(:overview_en, movie.overview)
    end

    remove_column :movies, :title
    remove_column :movies, :overview
  end

  def down
    add_column :movies, :title, :string
    add_column :movies, :overview, :text

    Movie.all.each do |movie|
      movie.update_attribute(:title, movie.title_en)
      movie.update_attribute(:overview, movie.overview_en)
    end

    LOCALES.each do |locale|
      remove_column :movies, "title_#{locale}"
      remove_column :movies, "overview_#{locale}"
    end
  end
end
