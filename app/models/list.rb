class List < ActiveRecord::Base
  attr_accessible :title, :user, :list_pattern

  belongs_to :user
  belongs_to :list_pattern
  has_many :list_belongings
  has_many :movies, :through => :list_belongings

  validates_presence_of :user
  validates_presence_of :title, :unless => :list_pattern

  def title
    list_pattern ? list_pattern.title : read_attribute(:title)
  end
end
