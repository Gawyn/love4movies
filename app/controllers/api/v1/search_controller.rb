class Api::V1::SearchController < ApplicationController
  def search
    @movies = Movie.standard_search params[:query]
    BackgroundSystem.enqueue(MovieSearcher, params[:query]) if params[:query]

    @movies = @movies.results.map do |movie| 
      { 
        title: movie.title, 
        year: movie.decorate.movie_year, 
        director: movie.decorate.directors_names
      }
    end

    render json: @movies
  end
end
