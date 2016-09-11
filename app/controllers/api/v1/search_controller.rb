class Api::V1::SearchController < ApplicationController
  def search
    @movies = Movie.standard_search params[:query]
    BackgroundSystem.enqueue(MovieSearcher, params[:query]) if params[:query]

    titles = @movies.results.map { |m| { title: m.title } }

    render json: titles
  end
end
