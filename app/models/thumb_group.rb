class ThumbGroup < ActiveRecord::Base
  belongs_to :public_account
  has_many :thumbs
  validates :name, length: { maximum: 6 }, presence: true
end
