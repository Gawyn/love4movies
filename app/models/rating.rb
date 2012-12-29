class Rating < ActiveRecord::Base
  attr_accessible :movie_id, :user_id, :value

  belongs_to :movie
  belongs_to :user

  validates_inclusion_of :value, :in => 1..10
  validates_presence_of :movie_id, :user_id
end
