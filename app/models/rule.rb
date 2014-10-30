class Rule < ActiveRecord::Base
  belongs_to :public_account
  has_many :kwords
  validates :name, length: { maximum: 60 }, presence: true
end
