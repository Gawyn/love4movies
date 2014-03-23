class BiographyAdder
  include Sidekiq::Worker

  def perform(person_id)
    person = Person.find person_id
    biography = TMDBClient.get_person(person.tmdb_id)["biography"]
    person.update_attribute(:biography, biography)
  end
end
