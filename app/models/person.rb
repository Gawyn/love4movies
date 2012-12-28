class Person < ActiveRecord::Base
  attr_accessible :name, :tmdb_profile_path, :tmdb_id
end
