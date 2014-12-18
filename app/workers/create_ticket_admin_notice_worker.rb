class CreateTicketAdminNoticeWorker
  include Sidekiq::Worker

  def perform(ticket_id)
    ticket = ::Ticket.find_by(id: ticket_id)
    return false if ticket.blank?
    need_be_noticed_users = ::User.where.not(:role => 0)
    need_be_noticed_users.each do |user|
      ::Notification.create(
        :messageable => ticket,
        :tp => 1,
        :subject => "您收到一条服务单<a href='/tickets/#{ticket.id}'>#{ticket.title}</a>",
        :body => ticket.body,
        :user => user
      )
    end
  end
end