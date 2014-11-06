class Kword < ActiveRecord::Base
  belongs_to :public_account
  belongs_to :subjectable, polymorphic: true
  belongs_to :rule
  validates :content, length: { maximum: 30 }, presence: true
  validates :public_account, presence: true
  validates :reply, presence: true, length: { maximum: 300 }, if: "subjectable_type == 'TextMaterial'"
  validates :subjectable_id, presence: true, if: "subjectable_id == 'SinMaterial'"

  ReplyType = {"TextMaterial" => "文字", "SinMaterial" => "单图文"}
  ReplyTypeNode = {"TextMaterial" => "text_material", "SinMaterial" => "sin_material"}
end
