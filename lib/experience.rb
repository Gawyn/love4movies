module Experience
  LOVE_EXPERIENCE = 1
  RATING_EXPERIENCE = 1
  SHORT_REVIEW_EXPERIENCE = 1 + RATING_EXPERIENCE

  def give_experience!(user, experience_points)
    user.reload.with_lock do
      user.update_attribute(:experience, user.experience + experience_points)
    end
  end

  def take_experience!(user, experience_points)
    user.reload.with_lock do
      user.update_attribute(:experience, user.experience - experience_points)
    end
  end
end
