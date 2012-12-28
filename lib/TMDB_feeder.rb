module TMDBFeeder
  class << self
    def generate_movies(query)
      results = TMDBClient.search(query, false)
      results.each do |result|
        tmdb_id = result["id"]
        unless Movie.find_by_tmdb_id(tmdb_id) 
          movie = generate_basic_movie(tmdb_id)
          generate_cast_and_crew(movie)
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

    def generate_cast_and_crew(movie)
      cast_and_crew = TMDBClient.get_cast(movie.tmdb_id)
      cast = cast_and_crew["cast"]
      crew = cast_and_crew["crew"]
      (cast + crew).each do |person_data|
        unless Person.find_by_tmdb_id(person_data["id"])
          movie.people.create(:tmdb_id => person_data["id"],
            :name => person_data["name"],
            :tmdb_profile_path => person_data["profile_path"])
        end
      end
    end
  end
end
