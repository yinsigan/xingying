class Contact < ActiveRecord::Base
  validates :name, :body, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  STATUS = { 0 => "未处理", 1 => "正在处理", 2 => "已处理完毕" }
end
