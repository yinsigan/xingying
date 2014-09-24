# encoding: utf-8
class Public < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :password, :tp, :image, presence: true
  TP={1 => "订阅号", 2 => "服务号"}
  mount_uploader :image, AvatarUploader
end
