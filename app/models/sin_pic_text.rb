class SinPicText < ActiveRecord::Base

  ClickResponse = {1 => "正文", 2 => "链接"}
  ClickResponseNode = {1 => "body", 2 => "link"}

  belongs_to :thumb
  belongs_to :sin_material, class_name: SinMaterial
  belongs_to :multi_material, class_name: MultiMaterial

  validates :title, :thumb, :desc, presence: true
  validates :desc, :length => { maximum: 120 }
  validates :title, :length => { maximum: 64 }
  validates :body, presence: true, if: "click_response == 1"
  VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :article_address, presence: true, format: { with: VALID_URL_REGEX }, if: "click_response == 2"

  before_save :add_pic_url

  private

  def add_pic_url
    self.pic_url = self.thumb.image_url.to_s
  end

end
