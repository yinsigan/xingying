class CreateTicketAdminNoticeWorker
  include Sidekiq::Worker

  def perform(ticket_id)
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
      logger.debug "create ticket admin notice #{ticket.id}"
    end
  end
end