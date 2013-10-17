module TMDBFeeder
  class << self
    def generate_movies(query)
      results = TMDBClient.search(query, false)
      results.each do |result|
        tmdb_id = result["id"]
        unless Movie.find_by_tmdb_id(tmdb_id) 
          generate_movie(tmdb_id)
        end
      end
    end

    def generate_movie(tmdb_id)
      movie = generate_basic_movie(tmdb_id)
      generate_cast_and_crew(movie)
      generate_images(movie)
    end

    private

    def generate_images(movie)
      images = TMDBClient.get_images(movie.tmdb_id)
      images["posters"].each do |poster|
        Poster.find_or_create(:file_path => poster["file_path"],
          :width => poster["width"], :height => poster["height"],
          :aspect_ratio => poster["aspect_ratio"], :movie_id => movie.id)
      end

      images["backdrops"].each do |backdrop|
        Backdrop.find_or_create(:file_path => backdrop["file_path"],
          :width => backdrop["width"], :height => backdrop["height"],
          :aspect_ratio => backdrop["aspect_ratio"], :movie_id => movie.id)
      end
    end

    def generate_basic_movie(tmdb_id)
      locale = LOCALES.first
      movie_data = TMDBClient.get_movie(tmdb_id, locale)
      movie = Movie.new
      [ "original_title", "release_date",
        "popularity", "revenue", "runtime", "budget",
        "imdb_id" ].each do |attribute|
          movie.send("#{attribute}=", movie_data["#{attribute}"])
        end

      [ "id", "vote_average", "vote_count", 
        "poster_path" ].each do |attribute|
        movie.send("tmdb_#{attribute}=", movie_data["#{attribute}"])
      end

      [ "title", "overview" ].each do |attribute|
        movie.send("#{attribute}_#{locale}=", movie_data["#{attribute}"])
      end

      movie.rating_average = movie.tmdb_vote_average

      movie_data["genres"].each do |genre_data|
        genre = Genre.find_or_create(:tmdb_id => genre_data["id"],
          :name => genre_data["name"])
        movie.genres << genre
      end

      (LOCALES - [LOCALES.first]).each do |locale|
        movie_data = TMDBClient.get_movie(tmdb_id, locale)
        ["title", "overview"].each do |attribute|
          movie.send("#{attribute}_#{locale}=", movie_data["#{attribute}"])
        end
      end

      movie.save
      movie
    end

    def generate_cast_and_crew(movie)
      cast_and_crew = TMDBClient.get_cast(movie.tmdb_id)
      cast = cast_and_crew["cast"]
      crew = cast_and_crew["crew"]
      cast.each do |person_data|
        person = Person.find_by_tmdb_id(person_data["id"])

        unless person.present?
          person = Person.create(:tmdb_id => person_data["id"],
            :name => person_data["name"],
            :tmdb_profile_path => person_data["profile_path"])
        end

        Performance.find_or_create(:person_id => person.id, 
          :movie_id => movie.id, :tmdb_order => person_data["order"],
          :character => person_data["character"])
      end

      crew.each do |person_data|
        person = Person.find_by_tmdb_id(person_data["id"])

        unless person.present?
          person = Person.create(:tmdb_id => person_data["id"],
            :name => person_data["name"],
            :tmdb_profile_path => person_data["profile_path"])
        end

        TechnicalParticipation.find_or_create(:person_id => person.id, 
          :movie_id => movie.id, :job => person_data["job"],
          :department => person_data["department"])
      end
    end
  end
end
