class TextMaterial < Material
  has_many :kwords, as: :subjectable
end
