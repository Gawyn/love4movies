class List < ActiveRecord::Base
  attr_accessible :title, :user

  belongs_to :user
end
