class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_all_as_read, only: [:index]
  def index
    @notifications = current_user.notifications.includes(:user).page(params[:page])
    @notifications_count = @notifications.total_count
  end

  def clear
    current_user.notifications.delete_all
    redirect_to notifications_path, flash: {alert: I18n.t('success_delete')}
  end

  def delete
    @delete_url = clear_notifications_path
    @confirm = I18n.t("notifications.delete.confirm")
    @remote = false
    render "shared/delete.js.erb", layout: false
  end

  private

  def mark_all_as_read
    current_user.notifications.unread.update_all(readed: true, updated_at: Time.now.utc)
  end
end