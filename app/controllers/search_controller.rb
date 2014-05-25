class SearchController < ApplicationController
  def search
    @movies = Movie.standard_search params[:query]
    @people = Person.standard_search params[:query]
    BackgroundSystem.enqueue(MovieSearcher, params[:query]) if params[:query]
  end
end
