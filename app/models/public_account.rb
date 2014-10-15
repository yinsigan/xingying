# encoding: utf-8
# https://github.com/rubysl/rubysl-securerandom/blob/2.0/lib/rubysl/securerandom/securerandom.rb
class PublicAccount < ActiveRecord::Base
  belongs_to :user
  has_many :sin_materials
  has_many :multi_materials
  has_many :thumb
  validates :name, :tp, :image, :user, presence: true
  validates :default_reply, allow_nil: true, length: { in: 1..600 }
  validates :name, length: { maximum: 30 }
  TP={1 => "订阅号", 2 => "服务号"}
  mount_uploader :image, AvatarUploader

  def incre_sin_material_count
    increment! :pic_text_count
  end

  before_create :generate_key

  private
  def generate_key
    self.weixin_secret_key = SecureRandom.urlsafe_base64(32).downcase
    self.weixin_token = SecureRandom.hex(12)
  end
end
