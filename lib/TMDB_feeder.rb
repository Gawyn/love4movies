module TMDBFeeder
  class << self
    def generate_movies(query)
      results = TMDBClient.search(query, false)
      results.each do |result|
        unless Movie.find_by_tmdb_id(result["id"]) 
          movie_data = TMDBClient.get_movie(result["id"])
          movie = generate_basic_movie(movie_data)
          movie.save
        end
      end
    end

    private

    def generate_basic_movie(movie_data)
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

      movie
    end
  end
end
