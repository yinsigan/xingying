class CreateThumbGroups < ActiveRecord::Migration
  def change
    create_table :thumb_groups do |t|
      t.string :name
      t.belongs_to :public_account, index: true

      t.timestamps
    end
  end
end
