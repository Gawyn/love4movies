module Experience
  LOVE_EXPERIENCE = 1
  RATING_EXPERIENCE = 1
  SHORT_REVIEW_EXPERIENCE = 1 + RATING_EXPERIENCE

  def give_experience!(user, experience_points)
    exp = user.experience || 0
    user.reload.with_lock do
      user.update_attribute(:experience, exp + experience_points)
    end
  end

  def take_experience!(user, experience_points)
    exp = user.experience || 0
    user.reload.with_lock do
      user.update_attribute(:experience, exp - experience_points)
    end
  end
end
