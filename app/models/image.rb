class Image < ActiveRecord::Base
  attr_accessible :aspect_ratio, :file_path, :height, :movie, :width

  belongs_to :movie
end
