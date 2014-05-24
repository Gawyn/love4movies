class SearchController < ApplicationController
  def search
    @type = params[:type] || "movies"
    @movies = Movie.standard_search params[:query]
    @people = Person.standard_search params[:query]
  end
end
