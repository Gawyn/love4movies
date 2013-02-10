class List < ActiveRecord::Base
  attr_accessible :title, :user, :list_pattern

  belongs_to :user
  belongs_to :list_pattern
  has_many :list_belongings
  has_many :movies, :through => :list_belongings

  validates_presence_of :user
  validates_presence_of :title, :unless => :list_pattern
  validates_uniqueness_of :title, :scope => :user_id
  validate :repeated_patterns
  validate :pattern_titles

  def title
    list_pattern ? list_pattern.title : read_attribute(:title)
  end

  private

  def repeated_patterns
    errors.add(:repeated_patterns, "The user already has a list of that pattern") if list_pattern_id && user.lists.pluck(:list_pattern_id).include?(list_pattern_id)
  end

  def pattern_titles
    errors.add(:pattern_titles, "There is a list pattern with the same title") if ListPattern.pluck(:title).include? title
  end
end
