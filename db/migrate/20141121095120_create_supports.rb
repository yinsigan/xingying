class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.string :title
      t.text :body
      t.belongs_to :support_category, index: true

      t.timestamps
    end
  end
end
