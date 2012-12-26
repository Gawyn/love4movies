module TMDBFeeder
  class << self
    def search_movies(query)
      TMDBClient.search(query, false)
    end
  end
end
