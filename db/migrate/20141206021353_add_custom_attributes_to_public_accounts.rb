class AddCustomAttributesToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :open_customed, :boolean, default: false
    add_column :public_accounts, :default_customed, :boolean, default: true
    add_column :public_accounts, :trigger_custom, :string
  end
end
