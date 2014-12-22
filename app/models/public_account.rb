# encoding: utf-8
# https://github.com/rubysl/rubysl-securerandom/blob/2.0/lib/rubysl/securerandom/securerandom.rb
class PublicAccount < ActiveRecord::Base
  include Elasticsearch::Model
  TP                = { 1 => "订阅号", 2 => "服务号" }
  ReplyType         = { 1 => "文字", 2 => "单图文" }
  ReplyTypeNode     = { 1 => "text_material", 2 => "sin_material" }
  AutoReplyTypeNode = { 1 => "text_material", 2 => "sin_material" }
  AutoReplyType     = { 1 => "文字", 2 => "单图文" }

  has_many :sin_materials, -> { order "id DESC" }
  has_many :multi_materials
  has_many :rules, dependent: :delete_all
  has_many :thumbs, -> { order "id DESC" }
  has_many :thumb_groups, dependent: :destroy
  has_many :kwords, dependent: :delete_all
  has_many :sin_pic_texts, through: :sin_materials
  has_many :menus, dependent: :delete_all

  belongs_to :user
  # 关注时回复
  belongs_to :default_sin_material, foreign_key: "default_material_id", class_name: SinMaterial
  # todo
  # belongs_to :default_thumb_material, foreign_key: "default_material_id", class_name: "ThumbMaterial"
  # 无匹配时回复
  belongs_to :autoreply_sin_material, foreign_key: "autoreply_material_id", class: SinMaterial

  validates :name, :tp, :image, :user, presence: true
  validates :default_reply, :autoreply, allow_nil: true, length: { in: 1..600 }
  validates :default_sin_material, presence: true, if: "reply_type == 2"
  # validates :autoreply_sin_material, presence: true, if: "autoreply_type == 2"
  validates :name, length: { maximum: 30 }

  mount_uploader :image, AvatarUploader

  def tp_enum
    PublicAccount::TP.invert.to_a
  end

  def reply_type_enum
    PublicAccount::ReplyType.invert.to_a
  end

  def autoreply_type_enum
    PublicAccount::AutoReplyType.invert.to_a
  end

  def incre_sin_material_count
    increment! :pic_text_count
  end

  def decre_sin_material_count
    decrement! :pic_text_count
  end

  before_create :generate_key
  after_create :generate_root_menu

  private
  def generate_key
    self.weixin_secret_key = SecureRandom.urlsafe_base64(32).downcase
    self.weixin_token = SecureRandom.hex(12)
  end

  def generate_root_menu
    root_menu = self.menus.build
    root_menu.save(validate: false)
  end
end
