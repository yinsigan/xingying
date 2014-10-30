class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.belongs_to :public_account, index: true

      t.timestamps
    end
  end
end
