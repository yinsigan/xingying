class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    @notifications_count = @notifications.count
  end
end
