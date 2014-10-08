class AddDefaultReplyToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :default_reply, :text
  end
end
