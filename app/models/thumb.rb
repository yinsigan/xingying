class Thumb < ActiveRecord::Base
  mount_uploader :image, WthumbUploader
  has_one :sin_pic_text
  belongs_to :public_account, counter_cache: true

  validates :image, presence: true
end
