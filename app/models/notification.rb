class Notification < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id", class_name: "User"
  belongs_to :sender, foreign_key: "sender_id", class_name: "User"

  belongs_to :messageable, polymorphic: true
end
