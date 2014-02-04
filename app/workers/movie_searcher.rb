class MovieSearcher
  include Sidekiq::Worker

  def perform(query)
    TMDBClient.search(query, false).each do |result|
      tmdb_id = result["id"]
      MovieGenerator.new.perform(tmdb_id) unless Movie.find_by_tmdb_id(tmdb_id)
    end
  end
end
