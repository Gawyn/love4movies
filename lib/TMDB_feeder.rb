module TMDBFeeder
  class << self
    def generate_movies(query)
      results = TMDBClient.search(query, false)
      results.each do |result|
        unless Movie.find_by_tmdb_id(result["id"]) 
          movie = generate_basic_movie(result["id"])
        end
      end
    end

    private

    def generate_basic_movie(tmdb_id)
      movie_data = TMDBClient.get_movie(tmdb_id)
      movie = Movie.new
      [ "title", "original_title", "release_date",
        "popularity", "revenue", "runtime", "budget",
        "overview", "imdb_id" ].each do |attribute|
          movie.send("#{attribute}=", movie_data["#{attribute}"])
        end

      [ "id", "vote_average", "vote_count", 
        "poster_path" ].each do |attribute|
        movie.send("tmdb_#{attribute}=", movie_data["#{attribute}"])
      end

      movie.save
      movie
    end
  end
end
