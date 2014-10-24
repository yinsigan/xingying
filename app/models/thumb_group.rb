class ThumbGroup < ActiveRecord::Base
  belongs_to :public_account
  validates :name, length: { maximum: 6 }, presence: true
end
