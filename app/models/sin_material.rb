class SinMaterial < Material
  has_many :kwords, as: :subjectable
  has_one :sin_pic_text
end
