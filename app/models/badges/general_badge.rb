class GeneralBadge < Badge
  has_many :images, through: :movies
end
