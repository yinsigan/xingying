class CreateKwords < ActiveRecord::Migration
  def change
    create_table :kwords do |t|
      t.string :content
      t.boolean :matched, default: false
      t.belongs_to :public_account, index: true

      t.timestamps
    end
  end
end
