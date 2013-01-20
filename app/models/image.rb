class Image < ActiveRecord::Base
  attr_accessible :aspect_ratio, :file_path, :height, :movie, :width,
    :type

  belongs_to :movie
end
