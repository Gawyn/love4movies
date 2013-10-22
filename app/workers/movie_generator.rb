class MovieGenerator
  include Sidekiq::Worker

  def perform(tmdb_id)
    MovieFeeder.generate_movie(tmdb_id)
  end
end
