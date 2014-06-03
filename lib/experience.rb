module Experience
  LOVE_EXPERIENCE = 1
  RATING_EXPERIENCE = 1
  SHORT_REVIEW_EXPERIENCE = 1 + RATING_EXPERIENCE

  EACH_LEVEL_EXPERIENCE = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 53, 56, 59, 62, 65, 68, 71, 75, 79, 83, 87, 91, 96, 101, 106, 111, 117, 123, 129, 135, 142, 149, 156, 164, 172, 181, 190, 200, 210, 221, 232, 244, 256, 269, 282, 296, 311, 327, 343, 360, 378, 397, 417, 438, 460, 483, 507, 532, 559, 587, 616, 647, 679, 713, 749, 786, 825, 866, 909, 954, 1002, 1052, 1105, 1160, 1218, 1279, 1343]
  SUM_LEVEL_EXPERIENCE = [10, 21, 33, 46, 60, 75, 91, 108, 126, 145, 165, 186, 208, 231, 255, 280, 306, 333, 361, 390, 420, 452, 486, 522, 560, 600, 642, 686, 732, 780, 830, 883, 939, 998, 1060, 1125, 1193, 1264, 1339, 1418, 1501, 1588, 1679, 1775, 1876, 1982, 2093, 2210, 2333, 2462, 2597, 2739, 2888, 3044, 3208, 3380, 3561, 3751, 3951, 4161, 4382, 4614, 4858, 5114, 5383, 5665, 5961, 6272, 6599, 6942, 7302, 7680, 8077, 8494, 8932, 9392, 9875, 10382, 10914, 11473, 12060, 12676, 13323, 14002, 14715, 15464, 16250, 17075, 17941, 18850, 19804, 20806, 21858, 22963, 24123, 25341, 26620, 27963]

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

  def experience_for_next_level(user)
    SUM_LEVEL_EXPERIENCE[user.level - 1]
  end

  def pending_experience_for_next_level(user)
    experience_for_next_level(user) - user.experience
  end
end
