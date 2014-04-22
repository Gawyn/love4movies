class DirectorBadge < Badge
  validates_presence_of :person_id
  belongs_to :director, class_name: "Person"
end
