class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :messageable, polymorphic: true

  scope :unread, -> { where(readed: false) }

  enum tp: [:system, :ticket_comment]

  validates :user, :body, :messageable, :tp, presence: true

end