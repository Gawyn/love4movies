class List < ActiveRecord::Base
  attr_accessible :title, :user

  belongs_to :user
  has_many :list_belongings
  has_many :movies, :through => :list_belongings
end
