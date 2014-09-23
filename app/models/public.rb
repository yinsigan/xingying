class Public < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
end
