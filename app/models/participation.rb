class Participation < ActiveRecord::Base
  attr_accessible :movie_id, :person_id

  belongs_to :movie
  belongs_to :person
end
