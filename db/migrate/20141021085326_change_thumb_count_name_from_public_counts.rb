class ChangeThumbCountNameFromPublicCounts < ActiveRecord::Migration
  def change
    rename_column :public_accounts, :thumb_count, :thumbs_count
  end
end
