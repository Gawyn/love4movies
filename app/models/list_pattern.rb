class ListPattern < ActiveRecord::Base
  attr_accessible :title

  has_many :lists

  validates_presence_of :title
end
