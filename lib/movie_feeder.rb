class MovieFeeder
  class << self
    def generate_movies(query)
      results = TMDBClient.search(query, false) || []
      results.each do |result|
        generate_movie(result['id'])
      end
    end

    def generate_movie(tmdb_id)
      return if Movie.find_by_tmdb_id(tmdb_id)
      movie = generate_basic_movie(tmdb_id)
      generate_cast_and_crew(movie)
      generate_images(movie)
    end

    def generate_movies_of_person(tmdb_person_id)
      credits = TMDBClient.get_person_credits(tmdb_person_id)

      crew_movies = credits["crew"] ? credits["crew"].map { |movie| movie["id"] } : []
      cast_movies = credits["cast"] ? credits["cast"].map { |movie| movie["id"] } : []

      movie_ids = crew_movies + cast_movies

      movie_ids.each do |movie_id|
        BackgroundSystem.enqueue(MovieGenerator, movie_id)
      end
    end

    def generate_images(owner)
      images = get_object_images(owner)
      [Poster, Backdrop, Profile].each do |image_subclass|
        image_instances = images[image_subclass.to_s.underscore.pluralize] || []
        image_instances.each do |image|
          image_subclass.find_or_create(
            :file_path => image["file_path"],
            :width => image["width"],
            :height => image["height"],
            :aspect_ratio => image["aspect_ratio"],
            :owner_id => owner.id, owner_type: owner.class.to_s
          )
        end
      end
    end

    private

    def get_object_images(object)
      if object.is_a? Person
        TMDBClient.get_person_images(object.tmdb_id)
      elsif object.is_a? Movie
        TMDBClient.get_images(object.tmdb_id)
      end
    end

    def generate_basic_movie(tmdb_id)
      locale = LOCALES.first
      movie_data = TMDBClient.get_movie(tmdb_id, locale)
      movie = Movie.new

      [ "original_title", "release_date",
        "popularity", "revenue", "runtime", "budget",
        "imdb_id", "adult", "tagline" ].each do |attribute|
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
      movie.l4m_rating_average = 0

      (movie_data["genres"] || []).each do |genre_data|
        genre = Genre.find_or_create(:tmdb_id => genre_data["id"],
          :name => genre_data["name"])
        movie.genres << genre
      end

      (movie_data["production_countries"] || []).each do |country_data|
        iso = country_data["iso_3166_1"]
        name = country_data["name"]
        country = Country.find_by_iso_3166_1_and_name(iso, name)

        if country.nil?
          country = Country.create(iso_3166_1: iso, name: name)
        end

        movie.countries << country
      end

      (LOCALES - [LOCALES.first]).each do |locale|
        localized_movie_data = TMDBClient.get_movie(tmdb_id, locale)
        ["title", "overview"].each do |attribute|
          movie.send("#{attribute}_#{locale}=", localized_movie_data["#{attribute}"])
        end
      end

      attrs = Movie::BASIC_ATTRIBUTES.map do |attr|
        movie.send(attr)
      end

      movie.hidden = false

      movie.save
      movie
    end

    def generate_cast_and_crew(movie)
      cast_and_crew = TMDBClient.get_cast(movie.tmdb_id) || Hash.new([])
      cast = cast_and_crew["cast"] || []
      crew = cast_and_crew["crew"] || []

      cast.each do |person_data|
        person = generate_person_with_data(person_data)

        Performance.find_or_create(:person_id => person.id,
          :movie_id => movie.id, :tmdb_order => person_data["order"],
          :character => person_data["character"])
      end

      crew.each do |person_data|
        person = generate_person_with_data(person_data)

        TechnicalParticipation.find_or_create(:person_id => person.id,
          :movie_id => movie.id, :job => person_data["job"],
          :department => person_data["department"])
      end
    end

    def generate_person_with_data(data)
      person = Person.find_by_tmdb_id(data["id"])

      unless person.present?
        data = TMDBClient.get_person(data["id"])
        person = Person.create(:tmdb_id => data["id"],
          :name => data["name"],
          biography: data["biography"],
          place_of_birth: data["place_of_birth"],
          birthday: data["birthday"] ?
            transform_to_date_with_rescue(data["birthday"]) : nil,
          deathday: data["deathday"] ?
            transform_to_date_with_rescue(data["deathday"]) : nil,
          :tmdb_profile_path => data["profile_path"])

        generate_images(person)
      end

      person
    end

    def transform_to_date_with_rescue(string_date)
      begin
        string_date.to_date
      rescue
        nil
      end
    end
  end
end
