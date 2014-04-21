class DirectorBadge < Badge
  validates_presence_of :person_id
  belongs_to :director, class_name: "Person"

  def movie_ids
    TechnicalParticipation.where(job: "Director", person_id: person_id).pluck(:movie_id)
  end
end
