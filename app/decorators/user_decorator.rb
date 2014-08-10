class UserDecorator < Draper::Decorator
  delegate_all

  def percentage_of_experience_achieved
    (achieved_experience_for_next_level.to_f/Experience::EACH_LEVEL_EXPERIENCE[level - 1]).round(3).to_f * 100
  end

  def achieved_experience_for_next_level
    Experience::EACH_LEVEL_EXPERIENCE[level - 1] - missing_experience_for_next_level 
  end

  def missing_experience_for_next_level
    next_level_experience - experience
  end

  def last_level_experience
    return 0 if level <= 1
    Experience::SUM_LEVEL_EXPERIENCE[level - 2]
  end

  def next_level_experience
    Experience::SUM_LEVEL_EXPERIENCE[level - 1]
  end
end
