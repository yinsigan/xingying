class RenameContentToNameFromKwords < ActiveRecord::Migration
  def change
    rename_column :kwords, :content, :name
  end
end
