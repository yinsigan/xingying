class Menu < ActiveRecord::Base
  belongs_to :public_account
  acts_as_nested_set dependent: :destroy
end
