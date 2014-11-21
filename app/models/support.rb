class Support < ActiveRecord::Base
  belongs_to :support_category
  validates :title, :body, :support_category, presence: true
end
