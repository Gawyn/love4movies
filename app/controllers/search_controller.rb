class SearchController < ApplicationController
  def search
    if Rails.env.production?
      @movies = Movie.standard_search params[:query]
      @people = Person.standard_search params[:query]
      BackgroundSystem.enqueue(MovieSearcher, params[:query]) if params[:query]
    else
      begin
        MovieSearcher.new.perform params[:query]
      rescue
      end
      @movies = Movie.where("original_title like ?", params[:query])
      @people = Person.where("name like ?", params[:query])
    end
  end
end
