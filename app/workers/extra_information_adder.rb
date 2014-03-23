class ExtraInformationAdder
  include Sidekiq::Worker

  def perform(person_id)
    person = Person.find person_id
    person_data = TMDBClient.get_person(person.tmdb_id)

    person.place_of_birth = person_data["place_of_birth"]
    person.birthday = person_data["birthday"].to_date if person_data["birthday"]
    person.deathday = person_data["deathday"].to_date if person_data["deathday"]
    person.save
  end
end
