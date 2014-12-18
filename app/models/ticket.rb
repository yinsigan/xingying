class Ticket < ActiveRecord::Base
  #todo 48小时未回复自动处理
  Status = {1 => "已提交", 2 => "正在处理", 3 => "已处理"}

  belongs_to :user
  has_many :comments, as: 'commentable'

  validates :title, presence: true, length: { maximum: 50 }
  validates :body,  presence: true, length: { in: 1..600 }
  validates :number, presence: true
  validates :user, presence: true

  default_scope { order "id DESC" }

  # after_commit :send_ticket_admin_notice, on: :create
  after_create :send_ticket_admin_notice

  def self.create_ticket_admin_notice(ticket_id)
    ticket = Ticket.find(ticket_id)
    need_be_noticed_users = User.where.not(:role => 0)
    need_be_noticed_users.each do |user|
      Notification.create(
        :messageable => ticket,
        :tp => 1,
        :subject => "您收到一条服务单<a href='/tickets/#{ticket.id}'>#{ticket.title}</a>",
        :body => ticket.body,
        :user => user
      )
    end
  end

  def status_enum
    Ticket::Status.invert.to_a
  end

  protected
    def send_ticket_admin_notice
      Ticket.delay.create_ticket_admin_notice(self.id)
    end
end
