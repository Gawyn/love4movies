class TechnicalParticipation < Participation
  after_create :check_existing_badge!

  private

  def check_existing_badge!
    Badge.where(person_id: person_id).each do |badge|
      if badge.class == DirectorBadge && job == "Director"
        MovieInBadge.create(movie_id: movie_id, badge_id: badge.id)
      end
    end
  end
end
