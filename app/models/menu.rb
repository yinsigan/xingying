class Menu < ActiveRecord::Base
  belongs_to :public_account

  validates :name, length: { maximum: 4 }

  acts_as_nested_set dependent: :destroy
end
