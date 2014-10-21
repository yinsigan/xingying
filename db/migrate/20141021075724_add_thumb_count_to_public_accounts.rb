class AddThumbCountToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :thumb_count, :integer, default: 0
  end
end
