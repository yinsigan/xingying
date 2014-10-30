class Rule < ActiveRecord::Base
  belongs_to :public_account
  has_many :kwords
end
