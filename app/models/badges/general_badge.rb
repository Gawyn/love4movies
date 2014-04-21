class GeneralBadge < Badge
  def movie_ids
    MovieInBadges.pluck(:movie_id)
  end
end
