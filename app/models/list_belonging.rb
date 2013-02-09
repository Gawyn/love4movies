class ListBelonging < ActiveRecord::Base
  attr_accessible :list_id, :movie_id

  belongs_to :list
  belongs_to :movie
end
