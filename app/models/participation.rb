class Participation < ActiveRecord::Base
  belongs_to :movie
  belongs_to :person
end
