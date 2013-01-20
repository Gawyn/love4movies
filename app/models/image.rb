class Image < ActiveRecord::Base
  IMAGE_BASE_URL = "http://cf2.imgobject.com/t/p/"

  attr_accessible :aspect_ratio, :file_path, :height, :movie_id, :width,
    :type

  belongs_to :movie

  def url(size)
    return unless self.class::SIZES.include?(size)
    IMAGE_BASE_URL + size + file_path
  end
end
