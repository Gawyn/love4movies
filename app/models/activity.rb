class Activity < ActiveRecord::Base
  belongs_to :content, polymorphic: true
  belongs_to :user
end
