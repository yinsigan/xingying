class CreateSupportCategories < ActiveRecord::Migration
  def change
    create_table :support_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
