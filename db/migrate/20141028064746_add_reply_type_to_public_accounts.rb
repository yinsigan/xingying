class AddReplyTypeToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :reply_type, :integer, default: 1
  end
end
