class SinMaterial < Material
  has_many :kwords, as: :subjectable
  has_one :sin_pic_text, dependent: :destroy
  belongs_to :public_account

  validates :public_account, presence: true

  accepts_nested_attributes_for :sin_pic_text

  after_create :incre_sin_material_count
  after_destroy :decre_sin_material_count

  def save_article_address(article_address)
    self.sin_pic_text.article_address = article_address
    self.save
  end

  private

  def incre_sin_material_count
    self.public_account.incre_sin_material_count
  end

  def decre_sin_material_count
    self.public_account.decre_sin_material_count
  end

end