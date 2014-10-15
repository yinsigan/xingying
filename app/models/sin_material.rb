class SinMaterial < Material
  has_many :kwords, as: :subjectable
  has_one :sin_pic_text
  belongs_to :public_account

  validates :public_account, presence: true

  accepts_nested_attributes_for :sin_pic_text
end
