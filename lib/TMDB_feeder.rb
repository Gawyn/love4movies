module TMDBFeeder
  class << self
    def search_movies(options)
      TmdbMovie.find(options)
    end
  end
end
