class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  validates :commentable_type, inclusion: { in: %w(Ticket) }
  validates :commentable, :user, presence: true
  validates :body, presence: true
end