class AddContentIndexToKwords < ActiveRecord::Migration
  def change
    add_index :kwords, :content
  end
end
