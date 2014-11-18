class DropTableTextReplies < ActiveRecord::Migration
  def change
    drop_table :text_replies
  end
end
