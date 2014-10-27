require 'file_size_validator'
class Thumb < ActiveRecord::Base
  mount_uploader :image, WthumbUploader
  has_one :sin_pic_text
  belongs_to :public_account, counter_cache: true
  belongs_to :thumb_group

  validates :image,
    :presence => true,
    :file_size => {
      :maximum => 5.megabytes.to_i
    }
  before_save :update_image_attributes

  private

  def update_image_attributes
    if image.present? && image_changed?
      self.content_type = image.file.content_type
      self.file_size = image.file.size
      self.file_name = image.file.original_filename
    end
  end
end
