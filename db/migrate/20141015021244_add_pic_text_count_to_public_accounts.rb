class AddPicTextCountToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :pic_text_count, :integer, default: 0
  end
end
