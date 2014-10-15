class Thumb < ActiveRecord::Base
  mount_uploader :image, WthumbUploader
  has_one :sin_pic_text

  validates :image, presence: true
end
