class Comment < ActiveRecord::Base
  attr_accessible :content, :movie_id, :user_id

  belongs_to :movie
  belongs_to :user
end
