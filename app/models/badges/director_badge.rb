class DirectorBadge < Badge
  validates_presence_of :person_id

  belongs_to :director, foreign_key: :person_id, class_name: "Person"
  has_many :images, through: :director

  after_create :mark_movies_for_badge!

  private

  def mark_movies_for_badge!
    movie_ids = TechnicalParticipation.where(person_id: person_id, job: "Director")
      .pluck(:movie_id)

    movie_ids.each do |movie_id|
      MovieInBadge.create(badge_id: id, movie_id: movie_id)
    end
  end
end
