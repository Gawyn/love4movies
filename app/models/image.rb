class Image < ActiveRecord::Base
  IMAGE_BASE_URL = "http://cf2.imgobject.com/t/p/"

  belongs_to :owner, polymorphic: true

  def url(size)
    return unless self.class::SIZES.include?(size)
    IMAGE_BASE_URL + size + file_path
  end
end
