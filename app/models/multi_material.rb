class MultiMaterial < Material
  has_many :kwords, as: :subjectable
  has_many :sin_pic_texts
end
