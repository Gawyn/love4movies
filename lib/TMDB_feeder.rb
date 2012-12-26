module TMDBFeeder
  class << self
    def search_movies(query)
      TMDBClient.search(query)
    end
  end
end
