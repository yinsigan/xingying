class CreatePublics < ActiveRecord::Migration
  def change
    create_table :publics do |t|
      t.string :name
      t.string :password
      t.integer :type

      t.timestamps
    end
  end
end
