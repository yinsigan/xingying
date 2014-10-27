class ThumbGroup < ActiveRecord::Base
  belongs_to :public_account
  has_many :thumbs, dependent: :nullify
  validates :name, length: { maximum: 6 }, presence: true
end
