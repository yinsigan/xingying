class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject
      t.text :body
      t.belongs_to :user, index: true
      t.belongs_to :sender, index: true
      t.belongs_to :messageable, polymorphic: true, index: true
      t.boolean    :readed, default: false

      t.timestamps
    end
  end
end
