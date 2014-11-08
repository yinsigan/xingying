class AddAutoreplyToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :autoreply_type, :integer, default: 1
    add_column :public_accounts, :autoreply, :text
    add_reference :public_accounts, :autoreply_material, index: true
  end
end
