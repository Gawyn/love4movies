class PeopleCreditsMovieGenerator
  include Sidekiq::Worker

  def perform(tmdb_id)
    MovieFeeder.generate_movies_of_person(tmdb_id)
  end
end
