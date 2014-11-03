class AddReplyToKwords < ActiveRecord::Migration
  def change
    add_column :kwords, :reply, :text
  end
end
