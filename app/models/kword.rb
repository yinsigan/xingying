class Kword < ActiveRecord::Base
  belongs_to :public_account
  belongs_to :subjectable, polymorphic: true
end
