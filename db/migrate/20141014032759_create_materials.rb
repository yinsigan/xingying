class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :type
      t.belongs_to :public_account, index: true

      t.timestamps
    end
  end
end
