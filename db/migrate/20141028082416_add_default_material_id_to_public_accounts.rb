class AddDefaultMaterialIdToPublicAccounts < ActiveRecord::Migration
  def change
    add_reference :public_accounts, :default_material, index: true
  end
end
