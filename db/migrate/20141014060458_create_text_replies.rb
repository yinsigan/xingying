class CreateTextReplies < ActiveRecord::Migration
  def change
    create_table :text_replies do |t|
      t.text :body
      t.belongs_to :text_material, index: true

      t.timestamps
    end
  end
end