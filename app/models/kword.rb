class Kword < ActiveRecord::Base
  belongs_to :public_account
  belongs_to :subjectable, polymorphic: true
  belongs_to :rule
  validates :content, length: { maximum: 30 }

  ReplyType = {"TextMaterial" => "文字", "SinMaterial" => "单图文"}
  ReplyTypeNode = {"TextMaterial" => "text_material", "SinMaterial" => "sin_material"}
end
