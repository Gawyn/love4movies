class ListPattern < ActiveRecord::Base
  attr_accessible :title

  has_many :lists
end
