class Rule < ActiveRecord::Base
  belongs_to :public_account
  has_many :kwords, -> { order "created_at ASC" }, dependent: :destroy
  validates :name, length: { maximum: 60 }, presence: true

  accepts_nested_attributes_for :kwords, allow_destroy: true
end
