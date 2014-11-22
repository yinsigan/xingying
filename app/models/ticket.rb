class Ticket < ActiveRecord::Base
  #todo 48小时未回复自动处理
  Status = {1 => "已提交", 2 => "正在处理", 3 => "已处理"}

  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :body,  presence: true, length: { in: 1..600 }
  validates :number, presence: true
  validates :user, presence: true

end
