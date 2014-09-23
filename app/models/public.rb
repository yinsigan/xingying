class Public < ActiveRecord::Base
  belongs_to :user
  validates :name, :password, presence: true
end
