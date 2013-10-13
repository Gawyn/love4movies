class ListPattern < ActiveRecord::Base
  has_many :lists

  validates_presence_of :title
  validates_uniqueness_of :title
end
