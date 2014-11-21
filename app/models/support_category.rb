class SupportCategory < ActiveRecord::Base
  has_many :supports, dependent: :delete_all
  validates :name, presence: true
end
