class SinPicText < ActiveRecord::Base
  belongs_to :thumb
  belongs_to :sin_material, class_name: SinMaterial
  belongs_to :multi_material, class_name: MultiMaterial

  validates :title, :body, :thumb, :desc, presence: true

  before_save :add_pic_url

  private

  def add_pic_url
    self.pic_url = self.thumb.image_url.to_s
  end

end
