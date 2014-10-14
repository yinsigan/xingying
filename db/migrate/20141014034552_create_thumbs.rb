class CreateThumbs < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.string :avatar

      t.timestamps
    end
  end
end
