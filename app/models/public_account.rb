# encoding: utf-8
# https://github.com/rubysl/rubysl-securerandom/blob/2.0/lib/rubysl/securerandom/securerandom.rb
class PublicAccount < ActiveRecord::Base
  belongs_to :user
  has_many :sin_materials
  has_many :multi_materials
  has_many :rules
  has_many :thumbs, -> { order "created_at DESC" }
  has_many :thumb_groups
  validates :name, :tp, :image, :user, presence: true
  validates :default_reply, allow_nil: true, length: { in: 1..600 }
  validates :name, length: { maximum: 30 }
  belongs_to :default_sin_material, foreign_key: "default_material_id", class_name: "SinMaterial"
  TP={1 => "订阅号", 2 => "服务号"}
  ReplyType = {1 => "文字", 2 => "单图文"}
  ReplyTypeNode = {1 => "text_material", 2 => "sin_material"}
  mount_uploader :image, AvatarUploader

  def incre_sin_material_count
    increment! :pic_text_count
  end

  def decre_sin_material_count
    decrement! :pic_text_count
  end

  before_create :generate_key

  private
  def generate_key
    self.weixin_secret_key = SecureRandom.urlsafe_base64(32).downcase
    self.weixin_token = SecureRandom.hex(12)
  end
end
