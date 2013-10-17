class MovieGenerator
  include Sidekiq::Worker

  def perform(tmdb_id)
    TMDBFeeder.generate_movie(tmdb_id)
  end
end
