class Participation < ActiveRecord::Base
  belongs_to :movie
  belongs_to :person

  validates_uniqueness_of :job, scope: [:movie_id, :person_id]
  validates_presence_of :movie, :person
end
