class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true
  has_many   :notifications

  validates :commentable_type, inclusion: { in: %w(Ticket) }
  validates :commentable, :user, presence: true
  validates :body, presence: true

  after_commit :send_ticket_comment_notice, on: :create

  def self.create_ticket_comment_notice(comment_id)
    comment = Comment.find(comment_id)
    need_be_noticed_users = (comment.commentable.comments.includes(:user).map(&:user) + Array.wrap(comment.commentable.user)).uniq - Array.wrap(comment.user)
    need_be_noticed_users.each do |user|
      Notification.create(
        :messageable => comment,
        :tp => 1,
        :subject => "您收到一条服务单<a href='/tickets/#{comment.commentable.id}'>#{comment.commentable.title}</a>的回复消息",
        :body => "#{comment.commentable.body}",
        :user => user
      )
    end
  end

  protected
    def send_ticket_comment_notice
      Comment.delay.create_ticket_comment_notice(self.id)
    end
end