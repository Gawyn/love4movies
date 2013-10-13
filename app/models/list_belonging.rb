class ListBelonging < ActiveRecord::Base
  belongs_to :list
  belongs_to :movie

  validates_uniqueness_of :movie_id, :scope => :list_id
end
