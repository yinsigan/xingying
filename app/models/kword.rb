class Kword < ActiveRecord::Base
  ReplyType = {"TextMaterial" => "文字", "SinMaterial" => "单图文"}
  ReplyTypeNode = {"TextMaterial" => "text_material", "SinMaterial" => "sin_material"}

  belongs_to :public_account
  belongs_to :subjectable, polymorphic: true
  belongs_to :rule
  belongs_to :sin_material, foreign_key: "subjectable_id", class_name: "SinMaterial"

  validates :name, length: { maximum: 30 }, presence: true
  validates :public_account, presence: true
  validates :reply, presence: true, length: { maximum: 300 }, if: "subjectable_type == 'TextMaterial'"
  validates :subjectable_id, presence: true, if: "subjectable_type == 'SinMaterial'"
  validates :subjectable_type, inclusion: { in: %w(SinMaterial TextMaterial) }

  def reply_content
    case subjectable_type
    when "TextMaterial"
      "1条文字"
    when "SinMaterial"
      "1条单图文"
    end
  end
end
