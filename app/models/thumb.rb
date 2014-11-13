require 'file_size_validator'
class Thumb < ActiveRecord::Base
  mount_uploader :image, WthumbUploader
  has_one :sin_pic_text
  belongs_to :public_account, counter_cache: true
  belongs_to :thumb_group
  belongs_to :thumb_material, class_name: ThumbMaterial, dependent: :destroy

  validates :image,
    :presence => true,
    :file_size => {
      :maximum => 5.megabytes.to_i
    }
  before_save :update_image_attributes
  after_create :create_thumb_material

  private

  def update_image_attributes
    if image.present? && image_changed?
      self.content_type = image.file.content_type
      self.file_size = image.file.size
      self.file_name = image.file.original_filename
    end
  end

  def create_thumb_material
    thumb_material = ThumbMaterial.create(public_account: self.public_account)
    self.thumb_material = thumb_material
    self.save
  end
end
