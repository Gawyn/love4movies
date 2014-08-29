class CountriesAdultAndTaglineInMovie
  def execute!
    Movie.find_each do |movie|
      movie_data = TMDBClient.get_movie(movie.tmdb_id)
      movie.tagline = movie_data["tagline"]
      movie.adult = movie_data["adult"]

      if movie_data["production_countries"]
        movie_data["production_countries"].each do |country_data|
          iso = country_data["iso_3166_1"]
          name = country_data["name"]
          country = Country.find_by_iso_3166_1_and_name(iso, name)

          if country.nil?
            country = Country.create(iso_3166_1: iso, name: name)
          end

          movie.countries << country
        end
      end

      movie.save
    end
  end
end
