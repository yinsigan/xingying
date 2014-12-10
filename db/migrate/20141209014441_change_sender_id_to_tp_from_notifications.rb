class ChangeSenderIdToTpFromNotifications < ActiveRecord::Migration
  def change
    rename_column :notifications, :sender_id, :tp
  end
end
